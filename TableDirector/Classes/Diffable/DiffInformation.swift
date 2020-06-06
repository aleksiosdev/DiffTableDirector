//
//  DiffableItem.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

public struct DiffInformation: DiffableCollection {
	public let diffId: String
	let diffableKeys: [String: String]

	public init(diffId: String, diffableKeys: [String: String]) {
		self.diffId = diffId
		self.diffableKeys = diffableKeys
	}

	public static func compareContent(_ left: Self, _ right: Self) -> Bool {
		return left.diffableKeys == right.diffableKeys
	}

	public static var randomItem: DiffInformation {
		let diffId = UUID().uuidString
		return DiffInformation(diffId: diffId, diffableKeys: [:])
	}
}




