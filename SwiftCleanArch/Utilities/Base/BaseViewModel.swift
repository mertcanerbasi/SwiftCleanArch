//
//  BaseViewModel.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import Foundation

class BaseViewModel {

    // Observable properties for loading and error states
    var isLoading: Observable<Bool> = Observable(false)
    var error: Observable<String?> = Observable(nil)

    // Functions to update states
    func setLoading(_ loading: Bool) {
        isLoading.value = loading
    }

    func setError(_ errorMessage: String?) {
        error.value = errorMessage
    }
}

