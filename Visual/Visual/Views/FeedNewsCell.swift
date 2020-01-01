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

    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = designLinkColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    internal lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    internal lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = designSubtitleColor
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    internal lazy var imagesContainerView: UIView = {
        let view  = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    internal lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    internal lazy var evenImagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    internal lazy var oddImagesStackView: UIStackView = {
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

    private func addTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func addNameLabel() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func addDescriptionLabel() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
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
            imagesContainerView.heightAnchor.constraint(equalToConstant: 240),
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

    internal func configure<T: FeedCollectionViewModelProtocol>(_ element: T) {
        nameLabel.text = element.name
        titleLabel.text = element.title
        descriptionLabel.text = element.description
        element.images.enumerated().forEach { (index, element) in
            if index.isMultiple(of: 2) {
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


#if DEBUG
import SwiftUI

struct FeedNewsCellRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String
    @Binding var nameLabel: String
    @Binding var descriptionLabel: String
    @Binding var avatar: UIImage?

    public typealias UIViewType = FeedNewsCell

    func makeUIView(context: UIViewRepresentableContext<FeedNewsCellRepresentable>) -> FeedNewsCell {
        return FeedNewsCell(frame: .zero)
    }

    func updateUIView(_ uiView: FeedNewsCell, context: UIViewRepresentableContext<FeedNewsCellRepresentable>) {
        uiView.titleLabel.text = titleLabel
        uiView.nameLabel.text = nameLabel
        uiView.descriptionLabel.text = descriptionLabel
        uiView.oddImagesStackView.addArrangedSubview(createImage())
        uiView.oddImagesStackView.addArrangedSubview(createImage())
        uiView.oddImagesStackView.addArrangedSubview(createImage())
        uiView.evenImagesStackView.addArrangedSubview(createImage())
        uiView.evenImagesStackView.addArrangedSubview(createImage())
        uiView.evenImagesStackView.addArrangedSubview(createImage())
    }

    func createImage() -> UIImageView {
        let imageView = UIImageView(image: avatar)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }

}

struct FeedNewsCell_Preview: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            FeedNewsCellRepresentable(titleLabel: .constant("Title Label"),
                                      nameLabel: .constant("Name label"),
                                      descriptionLabel: .constant("Description Label"),
                                      avatar: .constant(UIImage(named: "swift", in: Bundle.module, compatibleWith: nil)))
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(colorScheme)")
        }
        .previewLayout(.fixed(width: 365, height: 320))
        .padding(.horizontal, 8.0)
    }
}

#endif
