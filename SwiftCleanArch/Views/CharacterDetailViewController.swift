//
//  CharacterDetailViewController.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//



import UIKit
import SDWebImage

class CharacterDetailViewController: BaseViewController<CharacterDetailViewModel> {

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Custom initializer to inject the ViewModel
    init(viewModel: CharacterDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureView()
    }

    private func setupViews() {
        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            speciesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10),
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureView() {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        speciesLabel.text = viewModel.species
        genderLabel.text = viewModel.gender

        if let url = URL(string: viewModel.imageUrl) {
            characterImageView.sd_setImage(with: url)
        }
    }
}
