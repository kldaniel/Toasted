//
//  Toast.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 19..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import Foundation

private protocol Toastable {

    init(toastView: ToastView)

    func show(in containerView: UIView)

    func hide()

}

/// A Toast that can be represented on the screen.
///
/// A toast is an easy android-like alternative for UIAlertViews.
/// By default a toast will be hidden after 3 seconds it was shown.
/// You can alter this by changing the duration property of the Toast object.
///
///     let toast: Toast = Toast(title: String)
///     toast.show(in: self.view) // Will automatically fade after 3 seconds
///     toast.hide() // Hiding the toast manually. Optional to use.
public class Toast: Toastable {

    // MARK: - Properties

    private var toastView: ToastView

    private var timer: Timer?

    public var configuration: ToastConfiguration = ToastConfiguration()

    // MARK: - Constructors

    public required init(toastView: ToastView) {
        self.toastView = toastView
        self.toastView.configuration = configuration
    }

    /// Initializes a basic Toast that has only a title. Title can be changed later.
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

    /// Makes the Toast visible on the given view for the pre-defined duration.
    ///
    /// After that duration it will start to fade out.
    /// - Parameters:
    ///     - in: The view the Toast will be displayed in.
    public final func show(in containerView: UIView) {

        if containerView.subviews.contains(toastView) { return }

        toastView.isHidden = true

        containerView.addSubview(toastView)

        toastView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor, constant: 0.0
        ).isActive = true

        let bottomConstraint = toastView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -Toasted.bottomSpace
        )
        toastView.bottomConstraint = bottomConstraint
        bottomConstraint.isActive = true

        toastView.leadingAnchor.constraint(
            greaterThanOrEqualTo: containerView.leadingAnchor,
            constant: Toasted.outerPadding
        ).isActive = true

        toastView.trailingAnchor.constraint(
            lessThanOrEqualTo: containerView.trailingAnchor,
            constant: -Toasted.outerPadding
        ).isActive = true

        toastView.topAnchor.constraint(
            greaterThanOrEqualTo: containerView.topAnchor,
            constant: Toasted.outerPadding
        ).isActive = true

        show(animation: configuration.animationOption)

    }

    /// Makes the Toast visible on the screen for the pre-defined duration.
    ///
    /// After that duration it will start to fade out.
    /// - Parameters:
    ///     - in: The view the Toast will be displayed in.
    public func show() {
        guard let window: UIWindow = ToastHelper.applicationWindow() else { return }
        show(in: window)
    }

    /// Hides the Toast and removes it from the view.
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

// MARK: - Helper

extension Toast {

    /// Sets up the timer that is responsible for triggering fading and removal of the toast.
    ///
    /// If duration is set to zero, the toast wont be faded automatically, only by calling the
    /// hide() method on the toast or dismissing the view the ToastView was added to.
    private func setupFadeTimer() {

        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }

        // Duration 0 means its visible forever without fading
        if self.configuration.duration == 0 { return }

        self.timer = Timer.scheduledTimer(
            timeInterval: self.configuration.duration,
            target: self,
            selector: #selector(self.hide),
            userInfo: nil, repeats: false
        )

    }

    private func show(animation: AnimationOption) {

        if animation == .fadeIn {

            toastView.alpha = 0.0
            toastView.isHidden = false

            UIView.animate(
                withDuration: Toasted.becomesVisibleDuration,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {

                self.toastView.alpha = 1.0

            }, completion: { (_) in
                self.setupFadeTimer()
            })

        } else if animation == .bottomUp {

            toastView.alpha = 1.0
            toastView.bottomConstraint?.constant = toastView.frame.height
            toastView.isHidden = false

            toastView.superview?.layoutIfNeeded()

            UIView.animate(
                withDuration: Toasted.becomesVisibleDurationBottomUp,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {

                self.toastView.bottomConstraint?.constant = -Toasted.bottomSpace
                self.toastView.superview?.layoutIfNeeded()

            }, completion: { (_) in
                self.setupFadeTimer()
            })

        }

    }

    private func afterDuration() {
        self.toastView.removeFromSuperview()
    }

}
