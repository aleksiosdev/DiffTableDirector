//
//  ViewModelDiffable.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

/// View model that can be difference with others
public protocol ViewModelDiffable {
	var diffProperties: [AnyHashable] { get }
}

// MARK: - Default implementation for diffProperties
public extension ViewModelDiffable {
	var diffProperties: [AnyHashable] {
		let mirrow = Mirror(reflecting: self)
		return mirrow.children.reduce([], { result, property in
			guard let value = property.value as? AnyHashable else { return result }
			guard !((value is UIImage) || (value is UIColor) || (value is UIFont)) else { return result }
			return result + [value]
		})
	}
}

// MARK: - Default implementation for hashable view model
public extension ViewModelDiffable where Self: Hashable {
	var diffProperties: [AnyHashable] {
		return [self]
	}
}
