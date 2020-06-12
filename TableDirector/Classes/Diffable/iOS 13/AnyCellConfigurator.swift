//
//  AnyCellConfigurator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 31.05.2020.
//

import Foundation

struct AnyCellConfigurator: Hashable {
	static func == (lhs: AnyCellConfigurator, rhs: AnyCellConfigurator) -> Bool {
		let lhsDict = lhs.cellConfigurator.diffableItem.diffableKeys
		let rhsDict = rhs.cellConfigurator.diffableItem.diffableKeys
		let lhsDiffId = lhs.cellConfigurator.diffableItem.diffId
		let rhsDiffId = rhs.cellConfigurator.diffableItem.diffId
		return lhsDiffId == rhsDiffId && lhsDict == rhsDict
	}

	let cellConfigurator: CellConfigurator
	init(cellConfigurator: CellConfigurator) {
		self.cellConfigurator = cellConfigurator
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(cellConfigurator.diffableItem.diffableKeys)
		hasher.combine(cellConfigurator.diffableItem.diffId)
	}
}

// MARK: - Equatable
extension AnyCellConfigurator: Equatable { }
