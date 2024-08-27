//
//  CharacterTableViewCell.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {

    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(characterImageView)
        addSubview(nameLabel)
        addSubview(statusLabel)

        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func configure(with viewModel: CharacterViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        if let url = URL(string: viewModel.imageUrl) {
            characterImageView.sd_setImage(with: url)
        }
    }
}

