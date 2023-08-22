//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Диас Сайынов on 21.08.2023.
//

import UIKit

struct CardData {
    let image: String
    let text: String
    let character: Character
}

class ViewController: UIViewController {
    
    private var cardViewCoordinator: CardViewCoordinator?

    //setting scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //setting stack view
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    var yourDataArray: [CardData] = []
    
    var characters: [Character] = []

    override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1.00)
            
            view.addSubview(scrollView)
            scrollView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        
            fetchDataAndSetupCardViews()
        }

        //MARK: -- Setup Cards
        private func setupCardViews() {
            cardViewCoordinator = CardViewCoordinator(navigationController: navigationController)

            var currentRowStackView: UIStackView?
            
            for (index, cardData) in yourDataArray.enumerated() {
                if index % 2 == 0 {
                    currentRowStackView = createRowStackView()
                }
                
                let cardView = CardView()
                cardView.configure(image: cardData.image, text: cardData.text, coordinator: cardViewCoordinator!)
                currentRowStackView?.addArrangedSubview(cardView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(sender:)))
                cardView.addGestureRecognizer(tapGesture)
                
                // Set a fixed width for the card views
                cardView.widthAnchor.constraint(equalToConstant: (view.bounds.width - 24) / 2).isActive = true
            }
        }
    
    //MARK: -- When Cards are tapped
    @objc private func handleCardTap(sender: UITapGestureRecognizer) {
        print("Tapped")
           guard let cardView = sender.view as? CardView,
                 let cardTitle = cardView.textLabel.text else {
               return
           }
           print(characters)
           if let character = characters.first(where: { $0.name == cardTitle }) {
               print(character)
               cardViewCoordinator?.showDetailsView(cardImage: cardView.imageView.image, cardTitle: cardTitle, character: character)
           }
       }
        
        private func createRowStackView() -> UIStackView {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 8
            stackView.addArrangedSubview(rowStackView)
            return rowStackView
        }
    
    
    //MARK: -- Fetching url and retrivieng information
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                let characters = characterResponse.results
                self.characters = characters
                completion(characters)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func fetchDataAndSetupCardViews() {
        fetchCharacters { [weak self] fetchedCharacters in
            guard let fetchedCharacters = fetchedCharacters else {
                return
            }
            
            self?.yourDataArray = fetchedCharacters.map { character in
                return CardData(image: character.image, text: character.name, character: character)
            }
            
            DispatchQueue.main.async {
                self?.setupCardViews()
            }
        }
    }

}
