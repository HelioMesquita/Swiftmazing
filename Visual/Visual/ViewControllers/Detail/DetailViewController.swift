//
//  DetailViewController.swift
//  Visual
//
//  Created by Hélio Mesquita on 05/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

open class DetailViewController: BaseViewController {

    private var designTitleColor = UIColor.Design.title
    private var designSubtitleColor = UIColor.Design.subtitle
    private var designLineColor = UIColor.Design.line

    private var padding: CGFloat = 10
    private var imageSize: CGFloat = 118
    private var lineHeight: CGFloat = 1
    private var stackSpacing: CGFloat = 8

    var guide: UILayoutGuide {
        return view.layoutMarginsGuide
    }

    internal lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 26
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = designLineColor?.cgColor
        return imageView
    }()

    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    internal lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = designSubtitleColor
        return label
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = designLineColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        navigationItem.largeTitleDisplayMode = .never
    }

    private func configureViews() {
        addImageView()
        addTitleStackView()
        addTitleLabel()
        addAuthorLabel()
        addLine()
        addDescriptionStackView()
    }

    private func addImageView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding)
        ])
    }

    private func addTitleStackView() {
        view.addSubview(titleStackView)
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding)
        ])
    }

    private func addLine() {
        view.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            lineView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -padding),
            lineView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding),
            lineView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }

    private func addTitleLabel() {
        titleStackView.addArrangedSubview(titleLabel)
    }

    private func addAuthorLabel() {
        titleStackView.addArrangedSubview(authorLabel)
    }

    private func addDescriptionStackView() {
        view.addSubview(descriptionStackView)
        NSLayoutConstraint.activate([
            descriptionStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: padding),
            descriptionStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -padding),
            descriptionStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding)
        ])
    }

    public func setDescriptions(_ texts: [String]) {
        texts.forEach { descriptionStackView.addArrangedSubview(createLabelDescription($0)) }
    }

    private func createLabelDescription(_ text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = designSubtitleColor
        label.text = text
        return label
    }

    public func setTitle(_ text: String) {
        titleLabel.text = text
    }

    public func setAuthor(_ text: String) {
        authorLabel.text = text
    }

    public func setImage(_ url: URL) {
        imageView.sd_setImage(with: url)
    }

}
