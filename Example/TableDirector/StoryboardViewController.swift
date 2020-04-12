//
//  StoryboardViewController.swift
//  TableDirector
//
//  Created by aleksiosdev on 04/12/2020.
//  Copyright (c) 2020 aleksiosdev. All rights reserved.
//

import UIKit

class StoryboardViewController: UIViewController {
	// MARK: - UI
	@IBOutlet weak var tablView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

// MARK: - UITableViewDelegate
extension StoryboardViewController: UITableViewDelegate {

}

// MARK: - UITableViewDelegate
extension StoryboardViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		fatalError()
	}
}
