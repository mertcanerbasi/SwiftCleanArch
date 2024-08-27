//
//  CharacterListViewModel.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import Foundation

class CharacterListViewModel: BaseViewModel {

    private let characterService: CharacterServiceProtocol
    private(set) var characters: [Character] = [] {
        didSet {
            self.charactersDidChange?()
        }
    }
    var charactersDidChange: (() -> Void)?

    init(characterService: CharacterServiceProtocol = CharacterService()) {
        self.characterService = characterService
        super.init()
    }

    func fetchCharacters() {
        setLoading(true)
        characterService.fetchCharacters { [weak self] result in
            self?.setLoading(false)
            switch result {
            case .success(let characters):
                self?.characters = characters
            case .failure(let error):
                self?.setError(error.localizedDescription)
            }
        }
    }

    func characterViewModel(at index: Int) -> CharacterViewModel {
        return CharacterViewModel(character: characters[index])
    }

    var numberOfCharacters: Int {
        return characters.count
    }
}


//For Cells View Model
struct CharacterViewModel {
    let name: String
    let status: String
    let species: String
    let imageUrl: String

    init(character: Character) {
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.imageUrl = character.image
    }
}

