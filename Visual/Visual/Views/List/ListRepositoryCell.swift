//
//  RepositoryCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import SDWebImage

internal class ListRepositoryCell: UICollectionViewCell {

    private var designTitleColor = UIColor.Design.title
    private var designSubtitleColor = UIColor.Design.subtitle
    private var designLineColor = UIColor.Design.line
    private var designBackgroundColor = UIColor.Design.background
    private var designLinkColor = UIColor.Design.link

    private var imageHeight: CGFloat = 90
    private var lineHeight: CGFloat = 1
    private var stackViewPadding: CGFloat = 12
    private var additionalInfoWidth: CGFloat = 56
    private var additionalInfoHeight: CGFloat = 28
    private var additionalInfoPadding: CGFloat = 4

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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    internal lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = designLineColor
        label.layer.cornerRadius = 14
        label.clipsToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = designLinkColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    internal lazy var supplementaryInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = designSubtitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lineView: UIView = {
        let line = UIView()
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
        addTitleLabel()
        addDescriptionLabel()
        addAdditionalInfoLabel()
        addSupplementaryInfoLabel()
        addLine()
    }

    private func addRepositoryImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func addStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: stackViewPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func addLine() {
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }

    private func addTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
    }

    private func addDescriptionLabel() {
        stackView.addArrangedSubview(descriptionLabel)
    }

    private func addAdditionalInfoLabel() {
        addSubview(additionalInfoLabel)
        NSLayoutConstraint.activate([
            additionalInfoLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: stackViewPadding),
            additionalInfoLabel.widthAnchor.constraint(equalToConstant: additionalInfoWidth),
            additionalInfoLabel.heightAnchor.constraint(equalToConstant: additionalInfoHeight)
        ])
    }

    private func addSupplementaryInfoLabel() {
        addSubview(supplementaryInfoLabel)
        NSLayoutConstraint.activate([
            supplementaryInfoLabel.centerYAnchor.constraint(equalTo: additionalInfoLabel.centerYAnchor),
            supplementaryInfoLabel.leadingAnchor.constraint(equalTo: additionalInfoLabel.trailingAnchor, constant: additionalInfoPadding)
        ])
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageView.layer.borderColor = designLineColor?.cgColor
    }

    public func configure<T: ListCollectionViewModelProtocol>(_ element: T) {
        titleLabel.text = element.title
        descriptionLabel.text = element.description
        additionalInfoLabel.text = element.additionalInfo
        supplementaryInfoLabel.text = element.supplementaryInfo
        imageView.sd_setImage(with: element.image)
    }

}

#if DEBUG
import SwiftUI

struct ListRepositoryCellRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String
    @Binding var descriptionLabel: String
    @Binding var avatar: UIImage?
    @Binding var additionalInfo: String
    @Binding var supplementaryInfo: String

    public typealias UIViewType = ListRepositoryCell

    func makeUIView(context: UIViewRepresentableContext<ListRepositoryCellRepresentable>) -> ListRepositoryCell {
        return ListRepositoryCell(frame: .zero)
    }

    func updateUIView(_ uiView: ListRepositoryCell, context: UIViewRepresentableContext<ListRepositoryCellRepresentable>) {
        uiView.titleLabel.text = titleLabel
        uiView.descriptionLabel.text = descriptionLabel
        uiView.additionalInfoLabel.text = additionalInfo
        uiView.supplementaryInfoLabel.text = supplementaryInfo
    }

}

struct ListRepositoryCell_Preview: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ListRepositoryCellRepresentable(titleLabel: .constant("Name label"),
                                            descriptionLabel: .constant("Description Label"),
                                            avatar: .constant(UIImage.Design.swift),
                                            additionalInfo: .constant("27.3l"),
                                            supplementaryInfo: .constant("stars"))
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(colorScheme)")
        }
        .previewLayout(.fixed(width: 365, height: 118))
        .padding(.horizontal, 8.0)
    }
}

#endif
