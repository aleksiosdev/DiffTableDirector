//
//  TableSection.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import Foundation

/// Store configurators to create single section
public final class TableSection {
	public let rows: [CellConfigurator]
	public let identifier: String
	public let headerView: HeaderConfigurator?
	public let footerView: FooterConfigurator?

	public init(
		rows: [CellConfigurator],
		identifier: String = UUID().uuidString,
		headerView: HeaderConfigurator? = nil,
		footerView: FooterConfigurator? = nil) {
		self.rows = rows
		self.identifier = identifier
		self.headerView = headerView
		self.footerView = footerView
	}

	public var isEmpty: Bool {
		return rows.isEmpty
	}
}
