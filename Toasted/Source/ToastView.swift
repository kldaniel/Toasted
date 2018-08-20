//
//  BasicToastView.swift
//  Toasted
//
//  Created by Daniel Kiss on 2018. 08. 20..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit

public class ToastView: UIView {

    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = Toasted.cornerRadius
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
    }

}
