import UIKit
import SwiftUI

class CardView: UIView {
    private var coordinator: CardViewCoordinator?
    let viewController = ViewController()
    var characterView: [Character]?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1.00) // Set your background color
        view.layer.cornerRadius = 16.0 // Set your corner radius
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(textLabel)
        
        // Configure constraints for your subviews
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            // Background view constraints
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 202),
            backgroundView.widthAnchor.constraint(equalToConstant: 156),
                
            // Image view constraints
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 140),
                
            // Text label constraints
            textLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16),
            textLabel.widthAnchor.constraint(equalToConstant: 99),
            textLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    func configure(image: String, text: String, coordinator: CardViewCoordinator) {
           self.coordinator = coordinator
            if let url = URL(string: image) {
                loadImage(from: url)
            }
           textLabel.text = text
    }
}
