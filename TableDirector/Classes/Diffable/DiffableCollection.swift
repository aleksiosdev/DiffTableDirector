//
//  DiffableCollection.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation
import DeepDiff

/// Object must confirm protocol to be diffable
public protocol DiffableCollection: DiffAware {
	var id: String { get }

	static func compareContent(_ left: Self, _ right: Self) -> Bool
}
