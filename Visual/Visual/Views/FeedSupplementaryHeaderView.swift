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
    private var designLinkColor = UIColor.Design.link
    private let padding: CGFloat = 20.0

    internal lazy var callBack: (FeedSection) -> Void = { sender in }
    internal var section: FeedSection?
    internal let label: UILabel = UILabel()
    internal var button: UIButton?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addLabel()
        addButton()
        backgroundColor = designBackgroundColor
    }

    private func addLabel() {
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 1
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ])
    }

    private func addButton() {
        let button = UIButton(type: .system)
        self.button = button
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(buttonclicked), for: .touchUpInside)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.firstBaselineAnchor.constraint(equalTo: label.firstBaselineAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    @objc private func buttonclicked() {
        guard let section = section else { return }
        callBack(section)
    }

    internal func configure(_ section: FeedSection, callBack: @escaping (FeedSection) -> Void, buttonTitle: String = .seeMore) {
        self.section = section
        self.callBack = callBack
        label.text = section.rawValue.localized()
        button?.setTitle(buttonTitle, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#if DEBUG
import SwiftUI

internal struct FeedSupplementaryHeaderViewRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String
    @Binding var button: String

    public typealias UIViewType = FeedSupplementaryHeaderView

    func makeUIView(context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) -> FeedSupplementaryHeaderView {
        return FeedSupplementaryHeaderView(frame: .zero)
    }

    func updateUIView(_ uiView: FeedSupplementaryHeaderView, context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) {
        uiView.label.text = titleLabel
        uiView.button?.setTitle(button, for: .normal)
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
        .previewLayout(.fixed(width: 365, height: 40))
        .padding(.horizontal, 8.0)
    }
}

#endif
