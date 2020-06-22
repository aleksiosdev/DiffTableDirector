//
//  DiffableItem.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

/// Hold information to diff object
public struct DiffInfo: DiffableCollection {
	let properties: [AnyHashable]

	public init(properties: [AnyHashable]) {
		self.properties = properties
	}

	public static func compareContent(_ left: Self, _ right: Self) -> Bool {
		return left.properties == right.properties
	}

	public static var randomItem: DiffInfo {
		return DiffInfo(properties: [UUID().uuidString])
	}
}

// MARK: - Equatable
extension DiffInfo: Equatable { }

// MARK: - Hashable
extension DiffInfo: Hashable { }
