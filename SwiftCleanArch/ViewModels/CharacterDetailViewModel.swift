//
//  CharacterDetailViewModel.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//


import Foundation

class CharacterDetailViewModel: BaseViewModel {
    private let character: Character

    var name: String {
        return character.name
    }

    var status: String {
        return "Status: \(character.status)"
    }

    var species: String {
        return "Species: \(character.species)"
    }

    var gender: String {
        return "Gender: \(character.gender)"
    }

    var imageUrl: String {
        return character.image
    }

    init(character: Character) {
        self.character = character
        super.init()
    }
}
