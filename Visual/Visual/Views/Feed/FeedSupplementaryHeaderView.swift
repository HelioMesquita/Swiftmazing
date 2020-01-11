//
//  MainSupplementaryHeaderView.swift
//  Visual
//
//  Created by Helio Loredo Mesquita on 23/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public class FeedSupplementaryHeaderView: UICollectionReusableView {

    private var designTitleColor = UIColor.Design.title
    private var designBackgroundColor = UIColor.Design.background
    private let padding: CGFloat = 20.0

    internal lazy var callBack: (FeedSection) -> Void = { sender in }
    internal var section: FeedSection?

    internal lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = designTitleColor
        return label
    }()

    internal lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addLabel()
        addButton()
        backgroundColor = designBackgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLabel() {
        addSubview(label)
        label.text = "TEXTO"
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ])
    }

    private func addButton() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.firstBaselineAnchor.constraint(equalTo: label.firstBaselineAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    @objc private func buttonClicked() {
        guard let section = section else { return }
        callBack(section)
    }

    internal func configure(_ section: FeedSection, callBack: @escaping (FeedSection) -> Void, buttonTitle: String = Text.seeMore.value) {
        self.section = section
        self.callBack = callBack
        label.text = section.value
        button.setTitle(buttonTitle, for: .normal)
    }

}

#if DEBUG
import SwiftUI

internal struct FeedSupplementaryHeaderViewRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String
    @Binding var button: String

    public typealias UIViewType = FeedSupplementaryHeaderView

    func makeUIView(context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) -> FeedSupplementaryHeaderView {
        return FeedSupplementaryHeaderView()
    }

    func updateUIView(_ uiView: FeedSupplementaryHeaderView, context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) {
        uiView.label.text = titleLabel
        uiView.button.setTitle(button, for: .normal)
    }

}

internal struct FeedSupplementaryHeaderView_Preview: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            FeedSupplementaryHeaderViewRepresentable(titleLabel: .constant("Name label"),
                                                     button: .constant("See more"))
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(colorScheme)")
        }
        .previewLayout(.fixed(width: 375, height: 40))
        .padding(.horizontal, 8.0)
    }
}

#endif
