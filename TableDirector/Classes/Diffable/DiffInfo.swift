//
//  DiffableItem.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

/// Hold information to diff object
public struct DiffInfo: DiffableCollection {
	public let id: String
	let properties: [String: AnyHashable]

	public init(id: String, properties: [String: AnyHashable]) {
		self.id = id
		self.properties = properties
	}

	public static func compareContent(_ left: Self, _ right: Self) -> Bool {
		return left.properties == right.properties
	}

	public static var randomItem: DiffInfo {
		return DiffInfo(id: UUID().uuidString, properties: [:])
	}
}

// MARK: - Equatable
extension DiffInfo: Equatable { }

// MARK: - Hashable
extension DiffInfo: Hashable { }
