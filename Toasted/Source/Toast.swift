//
//  Toast.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 19..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation

private protocol Toastable {

    init(toastView: UIView)

    func show(in containerView: UIView)

    func hide()

}

public class Toast: Toastable {

    // MARK: - Constants

    private static var innerPadding: CGFloat = 8.0
    private static var cornerRadius: CGFloat = 6.0

    // MARK: - Properties

    private var toastView: UIView

    private var timer: Timer?

    var visibleDuration: TimeInterval = 3.0

    // MARK: - Constructors

    public required init(toastView: UIView) {
        self.toastView = toastView
    }

    public convenience init(title: String) {
        self.init(
            toastView: Toast.makeBasicToastView(title: title)
        )
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Core

    public final func show(in containerView: UIView) {

        containerView.addSubview(toastView)

        toastView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor, constant: 0.0
        ).isActive = true

        toastView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -48.0
        ).isActive = true

        if timer != nil {
            timer?.invalidate()
            timer = nil
        }

        timer = Timer.scheduledTimer(
            timeInterval: visibleDuration,
            target: self,
            selector: #selector(hide),
            userInfo: nil, repeats: true
        )

    }

    @objc public final func hide() {
        toastView.removeFromSuperview()
        timer?.invalidate()
        timer = nil
    }

}

// MARK: - Factory methods

extension Toast {

    private static func makeBasicToastView(title: String) -> UIView {

        let toastView: UIView = UIView(frame: .zero)
        toastView.backgroundColor = .gray
        toastView.clipsToBounds = true

        let titleLabel: UILabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()

        toastView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        toastView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(
            equalTo: toastView.leadingAnchor,
            constant: Toast.innerPadding
        ).isActive = true

        titleLabel.trailingAnchor.constraint(
            equalTo: toastView.trailingAnchor,
            constant: -Toast.innerPadding
        ).isActive = true

        titleLabel.topAnchor.constraint(
            equalTo: toastView.topAnchor,
            constant: Toast.innerPadding
        ).isActive = true

        titleLabel.bottomAnchor.constraint(
            equalTo: toastView.bottomAnchor,
            constant: -Toast.innerPadding
        ).isActive = true

        toastView.layer.cornerRadius = Toast.cornerRadius

        return toastView

    }

}
