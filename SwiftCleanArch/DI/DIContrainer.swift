import Swinject

class DIContainer {
    let container: Container

    init() {
        container = Container()

        // Register Services
        container.register(NetworkManager.self) { _ in
            NetworkManager.shared
        }.inObjectScope(.container)

        container.register(CharacterServiceProtocol.self) { resolver in
            CharacterService(networkManager: resolver.resolve(NetworkManager.self)!)
        }

        // Register ViewModels
        container.register(CharacterListViewModel.self) { resolver in
            CharacterListViewModel(characterService: resolver.resolve(CharacterServiceProtocol.self)!)
        }

        container.register(CharacterDetailViewModel.self) { (resolver, character: Character) in
            CharacterDetailViewModel(character: character)
        }

        // Register ViewControllers
        container.register(CharacterListViewController.self) { resolver in
            let viewModel = resolver.resolve(CharacterListViewModel.self)!
            return CharacterListViewController(viewModel: viewModel)
        }

        container.register(CharacterDetailViewController.self) { (resolver, character: Character) in
            let viewModel = resolver.resolve(CharacterDetailViewModel.self, argument: character)!
            return CharacterDetailViewController(viewModel: viewModel)
        }
    }

    func resolve<T>(_ type: T.Type) -> T! {
        guard let resolved = container.resolve(type) else {
            fatalError("Dependency of type \(type) could not be resolved. Please check your DI setup.")
        }
        return resolved
    }

    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T! {
        guard let resolved = container.resolve(type, argument: argument) else {
            fatalError("Dependency of type \(type) with argument \(argument) could not be resolved. Please check your DI setup.")
        }
        return resolved
    }
}
