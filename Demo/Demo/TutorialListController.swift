//
//  TutorialListController.swift
//  Demo
//
//  Created by Daniel Kiss on 2018. 08. 22..
//  Copyright © 2018. Daniel Kiss. All rights reserved.
//

import UIKit

class TutorialListController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tutorialTableView: UITableView!

    // MARK: - Properties

    private var tutorialTitles: [String] = [
        "Basic demo"
    ]

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UITableViewDataSource

extension TutorialListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()

        cell.textLabel?.text = tutorialTitles[indexPath.row]

        return cell
    }

}

// MARK: - UITableViewDelegate

extension TutorialListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToTutorial(indexPath.row)
    }

}

// MARK: - Core logic

extension TutorialListController {

    private func navigateToTutorial(_ index: Int) {
        if index == 0 {
            performSegue(withIdentifier: "kBasicDemo", sender: self)
        }
    }

}
