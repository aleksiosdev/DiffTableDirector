//
//  TableSection.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import Foundation

/// Store configurators to create single section
public final class TableSection {
	public let headerView: HeaderConfigurator?
	public let footerView: FooterConfigurator?
	public let rows: [CellConfigurator]

	public init(
		rows: [CellConfigurator],
		headerView: HeaderConfigurator? = nil,
		footerView: FooterConfigurator? = nil) {
		self.headerView = headerView
		self.footerView = footerView
		self.rows = rows
	}

	public var isEmpty: Bool {
		return rows.isEmpty
	}
}
