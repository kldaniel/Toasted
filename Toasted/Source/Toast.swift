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
    
    private static var becomesVisibleDuration: TimeInterval = 1.75
    
    private static var fadeDuration: TimeInterval = 1.75

    // MARK: - Properties

    private var toastView: UIView

    private var timer: Timer?

    var beforeFadeDuration: TimeInterval = 3.0

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

        if containerView.subviews.contains(toastView) { return }
        
        toastView.alpha = 0.0
        
        containerView.addSubview(toastView)

        toastView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor, constant: 0.0
        ).isActive = true

        toastView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -48.0
        ).isActive = true
        
        toastView.leadingAnchor.constraint(
            greaterThanOrEqualTo: containerView.leadingAnchor,
            constant: 16.0
        ).isActive = true
        
        toastView.trailingAnchor.constraint(
            greaterThanOrEqualTo: containerView.trailingAnchor,
            constant: -16.0
        ).isActive = true

        UIView.animate(withDuration: Toast.becomesVisibleDuration, delay: 0.0, options: [.curveEaseIn], animations: {
            self.toastView.alpha = 1.0
        }) { (isCompleted: Bool) in
            
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            
            self.timer = Timer.scheduledTimer(
                timeInterval: self.beforeFadeDuration,
                target: self,
                selector: #selector(self.hide),
                userInfo: nil, repeats: true
            )
            
        }

    }

    @objc public final func hide() {
        
        timer?.invalidate()
        timer = nil
        
        UIView.animate(withDuration: Toast.fadeDuration, delay: 0.0, options: [.curveEaseIn], animations: {
            self.toastView.alpha = 0.0
        }) { (_) in
            self.toastView.removeFromSuperview()
        }
        
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
