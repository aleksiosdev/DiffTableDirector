//
//  ViewModelDiffable.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

public protocol ViewModelDiffable {
	var diffId: String { get }
	var diffableKeys: [String: AnyHashable] { get }
}

public extension ViewModelDiffable {
	var diffableKeys: [String: AnyHashable] {
		let mirrow = Mirror(reflecting: self)
		return mirrow.children.reduce([:], { result, property in
			guard let label = property.label else { return result }
			guard let value = property.value as? AnyHashable else { return result }
			var result = result
			result[label] = value
			return result
		})
	}
}
