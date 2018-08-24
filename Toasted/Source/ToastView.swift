//
//  BasicToastView.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 20..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit

/// The view that is responsible for defining the look and feel of the Toast.
///
/// It can be subclassed for custom layouts and behaviors.
public class ToastView: UIView {

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = Toasted.cornerRadius
        self.backgroundColor = Toasted.defaultBackgroundColor
        self.clipsToBounds = true
    }

}
