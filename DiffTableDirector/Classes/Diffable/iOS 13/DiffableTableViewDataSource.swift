//
//  AppleStructComparator.swift
//  DeepDiff
//
//  Created by Aleksandr Lavrinenko on 30.05.2020.
//

import Foundation

@available(iOS 13.0, *)
final class DiffableTableViewDataSource: UITableViewDiffableDataSource<String, AnyCellConfigurator>, DiffableDataSource {

	override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<String, AnyCellConfigurator>.CellProvider) {
		super.init(tableView: tableView, cellProvider: cellProvider)

	}

	func apply(snapshot: Snapshot, animation: UITableView.RowAnimation, completion: @escaping () -> Void) {
		guard let snapshot = snapshot as? NSDiffableDataSourceSnapshot<String, AnyCellConfigurator> else {
			return
		}
		print("NEW")
		print(snapshot.itemIdentifiers)
		snapshot.itemIdentifiers.forEach({ print("\($0.hashValue) \n") })

		print("OLD")
		print(self.snapshot().itemIdentifiers)
		self.snapshot().itemIdentifiers.forEach({ print("\($0.hashValue) \n") })
		
		defaultRowAnimation = animation
		apply(snapshot, animatingDifferences: animation.enabled, completion: completion)
	}
}
