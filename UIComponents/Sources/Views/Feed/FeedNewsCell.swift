//
//  RepositoryCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import SDWebImage
import UIKit

public class FeedNewsCell: BaseUICollectionViewCell {

  private var designLinkColor = UIColor.Design.link
  private var designTitleColor = UIColor.Design.title
  private var designSubtitleColor = UIColor.Design.subtitle
  private var designLineColor = UIColor.Design.line
  private var designBackgroundColor = UIColor.Design.background

  private var imageContainerHeight: CGFloat = 216
  private var imageContainerTopSpacing: CGFloat = 12
  private var lineHeight: CGFloat = 0.5
  private var titlePadding: CGFloat = 10

  internal lazy var lineView: UIView = {
    let line = UIView()
    line.backgroundColor = designLineColor
    line.translatesAutoresizingMaskIntoConstraints = false
    return line
  }()

  internal lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = designLinkColor
    label.font = .systemFont(ofSize: 12, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  internal lazy var subtitleLabel: UILabel = {
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
    let view = UIView()
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
    addLineView()
    addTitleLabel()
    addNameLabel()
    addDescriptionLabel()
    addImageContainerView()
    addImageStackView()
  }

  private func addLineView() {
    addSubview(lineView)
    NSLayoutConstraint.activate([
      lineView.topAnchor.constraint(equalTo: topAnchor),
      lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      lineView.heightAnchor.constraint(equalToConstant: lineHeight),
    ])
  }

  private func addTitleLabel() {
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: titlePadding),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  private func addNameLabel() {
    addSubview(subtitleLabel)
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  private func addDescriptionLabel() {
    addSubview(descriptionLabel)
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }

  private func addImageContainerView() {
    addSubview(imagesContainerView)
    NSLayoutConstraint.activate([
      imagesContainerView.topAnchor.constraint(
        equalTo: descriptionLabel.bottomAnchor, constant: imageContainerTopSpacing),
      imagesContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imagesContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imagesContainerView.heightAnchor.constraint(equalToConstant: imageContainerHeight),
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
    titleLabel.text = element.title
    subtitleLabel.text = element.subtitle
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
    @Binding var subtitleLabel: String
    @Binding var descriptionLabel: String
    @Binding var avatar: UIImage?

    public typealias UIViewType = FeedNewsCell

    func makeUIView(context: UIViewRepresentableContext<FeedNewsCellRepresentable>) -> FeedNewsCell
    {
      return FeedNewsCell(frame: .zero)
    }

    func updateUIView(
      _ uiView: FeedNewsCell, context: UIViewRepresentableContext<FeedNewsCellRepresentable>
    ) {
      uiView.titleLabel.text = titleLabel
      uiView.subtitleLabel.text = subtitleLabel
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
        FeedNewsCellRepresentable(
          titleLabel: .constant("Title Label"),
          subtitleLabel: .constant("Name label"),
          descriptionLabel: .constant("Description Label"),
          avatar: .constant(UIImage.Design.swift)
        )
        .environment(\.colorScheme, colorScheme)
        .previewDisplayName("\(colorScheme)")
      }
      .previewLayout(.fixed(width: 365, height: 320))
      .padding(.horizontal, 8.0)
    }
  }

#endif
