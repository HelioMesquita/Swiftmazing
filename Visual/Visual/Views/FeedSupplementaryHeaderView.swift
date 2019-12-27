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
    private let padding: CGFloat = 30.0

    internal let label: UILabel = UILabel()
    internal var button: UIButton?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addLabel()
        addButton()
        backgroundColor = designBackgroundColor
    }

    func addLabel() {
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 1
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
        ])
    }

    func addButton() {
        let button = UIButton(type: .system)
        self.button = button
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.addTarget(self, action: #selector(buttonclicked), for: .touchUpInside)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }

    @objc func buttonclicked() {
        print("funcionando")
    }

    func configure(_ text: String,_ buttonTitle: String) {
        label.text = text
        self.button?.setTitle(buttonTitle, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#if DEBUG
import SwiftUI

struct FeedSupplementaryHeaderViewRepresentable: UIViewRepresentable {

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

struct FeedSupplementaryHeaderView_Preview: PreviewProvider {

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
