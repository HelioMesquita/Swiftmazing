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
    private let padding: CGFloat = 30.0
    let label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = designBackgroundColor
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.numberOfLines = 1
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#if DEBUG
import SwiftUI

struct FeedSupplementaryHeaderViewRepresentable: UIViewRepresentable {

    @Binding var titleLabel: String

    public typealias UIViewType = FeedSupplementaryHeaderView

    func makeUIView(context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) -> FeedSupplementaryHeaderView {
        return FeedSupplementaryHeaderView(frame: .zero)
    }

    func updateUIView(_ uiView: FeedSupplementaryHeaderView, context: UIViewRepresentableContext<FeedSupplementaryHeaderViewRepresentable>) {
        uiView.label.text = titleLabel
    }

}

struct FeedSupplementaryHeaderView_Preview: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            FeedSupplementaryHeaderViewRepresentable(titleLabel: .constant("Name label"))
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(colorScheme)")
        }
        .previewLayout(.fixed(width: 365, height: 80))
        .padding(.horizontal, 8.0)
    }
}

#endif
