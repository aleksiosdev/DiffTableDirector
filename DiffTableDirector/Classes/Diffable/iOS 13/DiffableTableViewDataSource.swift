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
		defaultRowAnimation = animation
		apply(snapshot, animatingDifferences: animation.enabled, completion: completion)
	}
}
