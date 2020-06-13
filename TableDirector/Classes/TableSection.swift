//
//  TableSection.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import Foundation

/// Store configurators to create single section
public final class TableSection {
	/// Cell configurators
	public let rows: [CellConfigurator]
	/// Section identifier for diffing between sections. Default value will be section index
	public let identifier: String?
	/// Configurator for header
	public let headerConfigurator: HeaderConfigurator?
	/// Configurator for footer
	public let footerConfigurator: FooterConfigurator?

	/// Default constructor
	/// - Parameters:
	///   - rows: rows configurators
	///   - identifier: section identifier
	///   - headerConfigurator: header configurator
	///   - footerConfigurator: footer configurator
	public init(
		rows: [CellConfigurator],
		identifier: String? = nil,
		headerConfigurator: HeaderConfigurator? = nil,
		footerConfigurator: FooterConfigurator? = nil) {
		self.rows = rows
		self.identifier = identifier
		self.headerConfigurator = headerConfigurator
		self.footerConfigurator = footerConfigurator
	}

	/// Flag that return true if rows is empty
	public var isEmpty: Bool {
		return rows.isEmpty
	}
}
