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
	public let headerConfigurator: HeaderConfigurator?
	public let footerConfigurator: FooterConfigurator?

	public init(
		rows: [CellConfigurator],
		identifier: String = UUID().uuidString,
		headerConfigurator: HeaderConfigurator? = nil,
		footerConfigurator: FooterConfigurator? = nil) {
		self.rows = rows
		self.identifier = identifier
		self.headerConfigurator = headerConfigurator
		self.footerConfigurator = footerConfigurator
	}

	public var isEmpty: Bool {
		return rows.isEmpty
	}
}
