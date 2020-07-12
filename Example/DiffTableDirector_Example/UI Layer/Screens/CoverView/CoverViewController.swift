//
//  CoverViewController.swift
//  DiffTableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.07.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit
import DiffTableDirector

final class CoverViewController: UIViewController {
	// MARK: - UI
	private let _tableView: UITableView = {
		let tableView = UITableView()
		tableView.separatorStyle = .none
		return tableView
	}()

	// MARK: - Properties
	private lazy var _tableDirector: TableDirectorInput = {
		return TableDirector(tableView: _tableView)
	}()

	var feedModels: [FeedModel] = []
	var infoModels: [InfoModel] = []

	// MARK: - Init
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nil, bundle: nil)

		view.backgroundColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(_tableView)
		_tableView.translatesAutoresizingMaskIntoConstraints = false

		[_tableView.topAnchor.constraint(equalTo: view.topAnchor),
		 _tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		 _tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		 _tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
			].forEach { $0.isActive = true }

		_tableDirector = TableDirector(tableView: _tableView)

		feedModels = _loadFeed()

		_tableDirector.clearAndShowView(viewFactory: { [unowned self] in
			self._createErrorView {  [weak self] in
				guard let self = self else { return }

				self.feedModels = self._loadFeed()
				let sections = self._createRows(feedModels: self.feedModels)
				self._tableDirector.reload(with: sections)
			}
		}, position: .default)
	}

	// MARK: - Fetch data
	private func _loadFeed() -> [FeedModel] {
		return (0..<80).map { (index)  in
			let randomNumber = Double.random(in: Range(uncheckedBounds: (lower: 1, upper: 1000)))
			return FeedModel(
				id: "\(index) \(randomNumber)",
				title: "Hi! I'm readonly cell №\(index)",
				content: "Some description",
				isMine: true)
		}
	}

	// MARK: - Helpers
	private func _createRows(feedModels: [FeedModel]) -> [CellConfigurator] {
		let placeholderImage = UIImage(named: "placeholder")
		let feedRows = feedModels.map { (feedModel: FeedModel) -> TableRow<FeedCell> in
			return TableRow<FeedCell>(
				viewModel: .init(
					diffID: feedModel.id,
					title: feedModel.title,
					content: feedModel.content,
					image: placeholderImage))
		}

		return feedRows
	}

	private func _createErrorView(actionBlock: @escaping () -> Void) -> UIView {
		return ErrorView(
			title: "Hi, i'm Cover View",
			description: "Show me when user recieve error. Better with some action that can help him to fix it.",
			actions: [ErrorView.Action(title: "Fix error", action: actionBlock)])
	}
}
