//
//  ViewController.swift
//  Demo
//
//  Created by Daniel Kiss on 2018. 08. 09..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit
import Toasted

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let toast1: Toast = Toast(title: "Hello, Toasted! Lorem ipsum dolor sit amet 1. Lorem ipsum dolor sit amet 2.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            toast1.show(in: self.view)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
