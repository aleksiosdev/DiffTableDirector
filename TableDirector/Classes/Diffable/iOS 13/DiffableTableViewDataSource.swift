//
//  AppleStructComparator.swift
//  DeepDiff
//
//  Created by Aleksandr Lavrinenko on 30.05.2020.
//

import Foundation

@available(iOS 13.0, *)
final class DiffableTableViewDataSource:
UITableViewDiffableDataSource<String, AnyCellConfigurator>, DiffableDataSource {
	func apply(snapshot: Snapshot, animated: Bool) {
		guard let snapshot = snapshot as? NSDiffableDataSourceSnapshot<String, AnyCellConfigurator> else {
			return
		}
		apply(snapshot, animatingDifferences: animated)
	}
}
