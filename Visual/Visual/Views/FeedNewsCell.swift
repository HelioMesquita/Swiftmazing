//
//  RepositoryCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import SDWebImage

public class FeedNewsCell: UICollectionViewCell {

    private var designLinkColor = UIColor.Design.link
    private var designTitleColor = UIColor.Design.title
    private var designSubtitleColor = UIColor.Design.subtitle
    private var designLineColor = UIColor.Design.line
    private var designBackgroundColor = UIColor.Design.background

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = designLinkColor
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = designSubtitleColor
        label.font = .systemFont(ofSize: 21, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imagesContainerView: UIView = {
        let view  = UIView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var evenImagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var oddImagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        backgroundColor = designBackgroundColor
        addTitleLabel()
        addNameLabel()
        addDescriptionLabel()
        addImageContainerView()
        addImageStackView()
    }

    func addTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func addNameLabel() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func addDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func addImageContainerView() {
        addSubview(imagesContainerView)
        NSLayoutConstraint.activate([
            imagesContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            imagesContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagesContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imagesContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imagesContainerView.heightAnchor.constraint(equalToConstant: 224),
        ])
    }

    private func addImageStackView() {
        imagesContainerView.addSubview(imagesStackView)
        NSLayoutConstraint.activate([
            imagesStackView.topAnchor.constraint(equalTo: imagesContainerView.topAnchor),
            imagesStackView.leadingAnchor.constraint(equalTo: imagesContainerView.leadingAnchor),
            imagesStackView.trailingAnchor.constraint(equalTo: imagesContainerView.trailingAnchor),
            imagesStackView.bottomAnchor.constraint(equalTo: imagesContainerView.bottomAnchor),
        ])
        imagesStackView.addArrangedSubview(oddImagesStackView)
        imagesStackView.addArrangedSubview(evenImagesStackView)
    }

    public func configure<T: FeedCollectionViewModelProtocol>(_ element: T) {
        nameLabel.text = element.name
        titleLabel.text = element.title
        descriptionLabel.text = element.description
        element.images.enumerated().forEach { (index, element) in
            if index % 2 == 0 {
                oddImagesStackView.addArrangedSubview(createImage(image: element))
            } else {
                evenImagesStackView.addArrangedSubview(createImage(image: element))
            }
        }
    }

    private func createImage(image: URL) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_setImage(with: image)
        return imageView
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        oddImagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        evenImagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

}
