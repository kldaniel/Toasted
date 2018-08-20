//
//  BasicToastView.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 21..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit

public class BasicToastView: ToastView {

    // MARK: - UI properties

    private var titleLabel: UILabel!

    // MARK: - Properties

    public var title: String = ""

    public var font: UIFont = UIFont.systemFont(
        ofSize: 13,
        weight: .regular
    )

    public var textColor: UIColor = .black

    // MARK: - Constructors

    public init(frame: CGRect, title: String) {
        super.init(frame: frame)

        self.title = title
        setupView()

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func setupView() {

        super.setupView()

        titleLabel = UILabel(frame: .zero)

        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: Toasted.innerPadding
            ).isActive = true

        titleLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -Toasted.innerPadding
            ).isActive = true

        titleLabel.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: Toasted.innerPadding
            ).isActive = true

        titleLabel.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: -Toasted.innerPadding
            ).isActive = true

    }

}
