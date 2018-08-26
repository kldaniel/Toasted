//
//  TutorialBasicController.swift
//  Demo
//
//  Created by Daniel Kiss on 2018. 08. 22..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit
import Toasted

class TutorialBasicController: UIViewController {

    @IBOutlet weak var show1Button: UIButton!
    @IBOutlet weak var show2Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic Demo"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension TutorialBasicController {

    @IBAction func actionShow1(_ sender: UIButton) {

        let toast: Toast = Toast(
            title: "Hello, Toasted! This is a simple toast you can display on the screen. "
                + "It is useful for showing quick information to the user."
        )
        toast.show(in: self.view)

    }

    @IBAction func actionShow2(_ sender: UIButton) {

        let toast: Toast = Toast(title: "Another quick message.")
        toast.show(in: self.view)

    }

}
