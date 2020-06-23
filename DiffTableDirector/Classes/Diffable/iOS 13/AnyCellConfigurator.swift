//
//  AnyCellConfigurator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 31.05.2020.
//

import Foundation

struct AnyCellConfigurator: Hashable {
	static func == (lhs: AnyCellConfigurator, rhs: AnyCellConfigurator) -> Bool {
		return rhs.cellConfigurator.hashableViewModel ==  lhs.cellConfigurator.hashableViewModel
	}

	let cellConfigurator: CellConfigurator
	
	init(cellConfigurator: CellConfigurator) {
		self.cellConfigurator = cellConfigurator
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(cellConfigurator.hashableViewModel)
	}
}

// MARK: - Equatable
extension AnyCellConfigurator: Equatable { }
