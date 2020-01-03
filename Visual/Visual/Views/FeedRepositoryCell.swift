//
//  RepositoryCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import SDWebImage

internal class FeedRepositoryCell: UICollectionViewCell {

    private var designTitleColor = UIColor.Design.title
    private var designSubtitleColor = UIColor.Design.subtitle
    private var designLineColor = UIColor.Design.line
    private var designBackgroundColor = UIColor.Design.background

    private var imageHeight: CGFloat = 60
    private var lineHeight: CGFloat = 0.5
    private var linePadding: CGFloat = -8
    private var stackViewPadding: CGFloat = 12

    internal lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = designLineColor?.cgColor
        return imageView
    }()

    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    internal lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = designSubtitleColor
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var lineView: UIView = {
        let line = UIView()
        line.isHidden = true
        line.backgroundColor = designLineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
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
        addRepositoryImageView()
        addStackView()
        addNameLabel()
        addSubtitleLabel()
        addLine()
    }

    private func addRepositoryImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func addStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: stackViewPadding),
            stackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func addLine() {
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: linePadding),
            lineView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }

    private func addNameLabel() {
        stackView.addArrangedSubview(titleLabel)
    }

    private func addSubtitleLabel() {
        stackView.addArrangedSubview(descriptionLabel)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageView.layer.borderColor = designLineColor?.cgColor
    }

    public func configure<T: FeedCollectionViewModelProtocol>(_ element: T, index: Int, numberOfElements: Int) {
        titleLabel.text = element.title
        descriptionLabel.text = element.description
        imageView.sd_setImage(with: element.images.first)
        lineView.isHidden = (index + 1).isMultiple(of: numberOfElements)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        lineView.isHidden = false
    }

}

#if DEBUG
import SwiftUI

struct FeedRepositoryCellRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String
    @Binding var descriptionLabel: String
    @Binding var avatar: UIImage?

    public typealias UIViewType = FeedRepositoryCell

    func makeUIView(context: UIViewRepresentableContext<FeedRepositoryCellRepresentable>) -> FeedRepositoryCell {
        return FeedRepositoryCell(frame: .zero)
    }

    func updateUIView(_ uiView: FeedRepositoryCell, context: UIViewRepresentableContext<FeedRepositoryCellRepresentable>) {
        uiView.titleLabel.text = titleLabel
        uiView.descriptionLabel.text = descriptionLabel
        uiView.imageView.image = avatar
    }

}

struct FeedRepositoryCell_Preview: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            FeedRepositoryCellRepresentable(titleLabel: .constant("Name label"),
                                            descriptionLabel: .constant("Description Label"),
                                            avatar: .constant(UIImage.Design.swift))
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(colorScheme)")
        }
        .previewLayout(.fixed(width: 365, height: 80))
        .padding(.horizontal, 8.0)
    }
}

#endif
