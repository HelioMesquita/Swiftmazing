//
//  RepositoryCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
//import SDWebImage

public class RepositoryCell: UICollectionViewCell {

    private var titleColor = UIColor.Design.title
    private var subtitleColor = UIColor.Design.subtitle

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = titleColor
        label.text = "testing"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "testing"
        label.textColor = subtitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        backgroundColor = UIColor.Design.background
        contentView.backgroundColor = UIColor.Design.background
        addRepositoryImageView()
        addNameLabel()
        addSubtitleLabel()
    }

    private func addRepositoryImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
        ])
    }

    private func addNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
        ])
    }

    private func addSubtitleLabel() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
        ])
    }

    public func configure<T: MainCollectionViewModelProtocol>(_ element: T) {
        nameLabel.text = element.name
        descriptionLabel.text = element.description
//        imageView.sd_setImage(with: element.image)
    }

}
