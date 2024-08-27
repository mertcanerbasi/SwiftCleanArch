//
//  Observable.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
