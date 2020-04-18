//
//  TableDirectorInput.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

/// Interface for TableDirector. Provides all nessasry operation for users
public protocol TableDirectorInput: class {

	/// Reload table view with provided rows
	/// - Parameter rows: new table rows
	func reload(with rows: [[CellConfigurator]])

	/// Got index path of cell if it exist in table view
	/// - Parameter cell: table cell to find indexPath
	func indexPath(for cell: UITableViewCell) -> IndexPath?
}
