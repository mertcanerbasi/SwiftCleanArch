//
//  CharacterService.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<[Character], APIError>) -> Void)
}

class CharacterService: CharacterServiceProtocol {
    private let networkManager: NetworkManager
    private let characterURL = URL(string: "https://rickandmortyapi.com/api/character")!

    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchCharacters(completion: @escaping (Result<[Character], APIError>) -> Void) {
        guard networkManager.isInternetAvailable() else {
            completion(.failure(.requestFailed))  // Or define a specific error for no internet
            return
        }

        networkManager.performRequest(url: characterURL) { (result: Result<CharacterResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct CharacterResponse: Codable {
    let results: [Character]
}
