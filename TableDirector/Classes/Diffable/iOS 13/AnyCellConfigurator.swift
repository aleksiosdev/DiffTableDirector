//
//  AnyCellConfigurator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 31.05.2020.
//

import Foundation

struct AnyCellConfigurator: Hashable {
	static func == (lhs: AnyCellConfigurator, rhs: AnyCellConfigurator) -> Bool {
		let lhsDict = lhs.cellConfigurator.diffInfo.properties
		let rhsDict = rhs.cellConfigurator.diffInfo.properties
		let lhsDiffId = lhs.cellConfigurator.diffInfo.diffId
		let rhsDiffId = rhs.cellConfigurator.diffInfo.diffId
		return lhsDiffId == rhsDiffId && lhsDict == rhsDict
	}

	let cellConfigurator: CellConfigurator
	init(cellConfigurator: CellConfigurator) {
		self.cellConfigurator = cellConfigurator
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(cellConfigurator.diffInfo.properties)
		hasher.combine(cellConfigurator.diffInfo.diffId)
	}
}

// MARK: - Equatable
extension AnyCellConfigurator: Equatable { }
