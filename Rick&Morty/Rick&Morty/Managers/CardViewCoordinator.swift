import SwiftUI

//Navigating to SwiftUI file
class CardViewCoordinator: NSObject, ObservableObject {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showDetailsView(cardImage: UIImage?, cardTitle: String?, character: Character) {
        let detailsView = DetailsView(cardImage: Image(uiImage: cardImage!), cardText: cardTitle ?? "", character: character)
        let hostingController = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

