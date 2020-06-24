//
//  AnyCellConfigurator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 31.05.2020.
//

import Foundation

struct AnyCellConfigurator: Hashable {
	let hashableModel: AnyHashable

	static func == (lhs: AnyCellConfigurator, rhs: AnyCellConfigurator) -> Bool {
		return rhs.hashableModel ==  lhs.hashableModel
	}

	let cellConfigurator: CellConfigurator
	
	init(cellConfigurator: CellConfigurator) {
		self.cellConfigurator = cellConfigurator
		self.hashableModel = cellConfigurator.hashableModel ?? UUID().uuidString as AnyHashable
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(hashableModel)
	}
}

// MARK: - Equatable
extension AnyCellConfigurator: Equatable { }
