//
//  BaseViewController.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//


import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {

    var viewModel: T!

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        bindViewModel()
    }

    private func setupLoadingIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    func bindViewModel() {
        // Bind the loading state
        viewModel.isLoading.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }

        // Bind the error state
        viewModel.error.bind { [weak self] errorMessage in
            if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    AlertHelper.showAlert(on: self!, title: "Error", message: errorMessage)
                }
            }
        }
    }
}

