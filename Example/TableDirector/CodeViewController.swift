//
//  CodeViewController.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
	// MARK: - UI
	private let _tablView: UITableView = {
		let tableView = UITableView()
		tableView.separatorStyle = .none
		return tableView
	}()

	// MARK: - Init
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nil, bundle: nil)
		_tablView.delegate = self
		_tablView.dataSource = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(_tablView)
		_tablView.translatesAutoresizingMaskIntoConstraints = false
		
		[_tablView.topAnchor.constraint(equalTo: view.topAnchor),
			_tablView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			_tablView.leftAnchor.constraint(equalTo: view.leftAnchor),
			_tablView.rightAnchor.constraint(equalTo: view.rightAnchor)
			].forEach { $0.isActive = true }
	}
}

// MARK: - UITableViewDelegate
extension CodeViewController: UITableViewDelegate {

}

// MARK: - UITableViewDelegate
extension CodeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		fatalError()
	}
}
