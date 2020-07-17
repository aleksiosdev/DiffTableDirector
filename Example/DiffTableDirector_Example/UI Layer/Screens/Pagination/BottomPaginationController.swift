//
//  PaginationController.swift
//  DiffTableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.07.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit
import DiffTableDirector

final class BottomPaginationController: UIViewController {
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

	private var _firstPageLoaded: Bool = false

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

		[_tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		 _tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		 _tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
		 _tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
			].forEach { $0.isActive = true }

		_tableDirector = TableDirector(tableView: _tableView)

		feedModels = _loadFeed()

		let rows = self._createRows(feedModels: self.feedModels)
		let reloadRule = TableDirector.ReloadRule.calculateReloadAsync(queue: DispatchQueue.global())
		self._tableDirector.reload(with: rows, reloadRule: reloadRule)

		let bottomPaginationController = PaginationController(
			settings: .init(direction: .down, prefetch: .base(offsetFromLast: 0)),
			loader: .deafult) { (handler) in
				// Fake delay
				DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
					handler.finished(isSuccessfull: !self._firstPageLoaded, canLoadNext: true)
					if !self._firstPageLoaded {
						self.feedModels = self.feedModels + self._loadFeed()
						self._tableDirector.reload(with: self._createRows(feedModels: self.feedModels))
						self._firstPageLoaded = true
					}
				}
		}
		_tableDirector.add(paginationController: bottomPaginationController)
	}

	// MARK: - Fetch data
	private func _loadFeed() -> [FeedModel] {
		return (0..<40).map { (index)  in
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
}
