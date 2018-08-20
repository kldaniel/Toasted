//
//  Toast.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 19..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation

private protocol Toastable {

    init(toastView: BasicToastView)

    func show(in containerView: UIView)

    func hide()

}

public class Toast: Toastable {

    // MARK: - Properties

    private var toastView: BasicToastView

    private var timer: Timer?

    public var duration: TimeInterval = Toasted.defaultDuration

    // MARK: - Constructors

    public required init(toastView: BasicToastView) {
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

        if containerView.subviews.contains(toastView) { return }

        toastView.alpha = 0.0

        containerView.addSubview(toastView)

        toastView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor, constant: 0.0
        ).isActive = true

        toastView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -Toasted.bottomSpace
        ).isActive = true

        toastView.leadingAnchor.constraint(
            greaterThanOrEqualTo: containerView.leadingAnchor,
            constant: Toasted.outerPadding
        ).isActive = true

        toastView.trailingAnchor.constraint(
            greaterThanOrEqualTo: containerView.trailingAnchor,
            constant: -Toasted.outerPadding
        ).isActive = true

        toastView.topAnchor.constraint(
            greaterThanOrEqualTo: containerView.topAnchor,
            constant: Toasted.outerPadding
        ).isActive = true

        UIView.animate(
            withDuration: Toasted.becomesVisibleDuration,
            delay: 0.0,
            options: [.curveEaseIn],
        animations: {
            self.toastView.alpha = 1.0
        }, completion: { (_) in

            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }

            self.timer = Timer.scheduledTimer(
                timeInterval: self.duration,
                target: self,
                selector: #selector(self.hide),
                userInfo: nil, repeats: true
            )

        })

    }

    @objc public final func hide() {

        timer?.invalidate()
        timer = nil

        UIView.animate(
            withDuration: Toasted.fadeDuration,
            delay: 0.0, options: [.curveEaseIn],
        animations: {
            self.toastView.alpha = 0.0
        }, completion: { (_) in
            self.toastView.removeFromSuperview()
        })

    }

}

// MARK: - Factory methods

extension Toast {

    private static func makeBasicToastView(title: String) -> BasicToastView {
        let toastView: BasicToastView = BasicToastView(frame: .zero, title: title)
        return toastView
    }

}
