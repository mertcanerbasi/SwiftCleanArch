import UIKit

class AppCoordinator {
    var navigationController: UINavigationController
    var diContainer: DIContainer

    init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.navigationController.navigationBar.backgroundColor = .systemBackground
        self.navigationController.navigationBar.tintColor = .red
    }

    func start() {
        if let characterListViewController = diContainer.resolve(CharacterListViewController.self) {
            characterListViewController.title = "Characters"
            characterListViewController.coordinator = self // Inject coordinator
            navigationController.pushViewController(characterListViewController, animated: true)
        }
    }

    func showCharacterDetail(character: Character) {
        if let characterDetailViewController = diContainer.resolve(CharacterDetailViewController.self, argument: character) {
            navigationController.pushViewController(characterDetailViewController, animated: true)
        }
    }
}
