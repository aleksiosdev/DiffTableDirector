//
//  TableDirectorInput.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

/// Interface for TableDirector. Provides all nessasry operation for users
public protocol TableDirectorInput: class {
	/// Observe bounds cross on top
	var topCrossObserver: ThresholdCrossObserver? { get set }

	/// Observe bounds cross on bottom
	var bottomCrossObserver: ThresholdCrossObserver? { get set }

	/// Recieve didScroll events from scroll view
	var scrollObserable: ScrollObserverable? { get set }

	/// Flat that enables automated registration. True by default
	var isSelfRegistrationEnabled: Bool { get set }

	/// Connect table director to specific table view
	/// - Parameter tableView: table view
	func connect(to tableView: UITableView)

	/// Add pagination controller to table view.
	/// If pagination controller with provided direction already exist - it will be replaced with new one
	/// - Parameter paginationController: control pagination proccess
	func add(paginationController: PaginationController)

	/// Reload table view animated with provided sections
	/// - Parameter sections: new table sections
	func reload(with sections: [TableSection])

	/// Reload table view animated with provided sections
	/// - Parameters:
	///   - sections: new table sections
	///   - reloadRule: update table rule
	func reload(with sections: [TableSection], reloadRule: TableDirector.ReloadRule)

	/// Reload table view with provided sections
	/// - Parameters:
	///   - sections: new table sections
	///   - reloadRule: update table rule
	///   - animated: should use table view default animation
	func reload(with sections: [TableSection], reloadRule: TableDirector.ReloadRule, animated: Bool)

	/// Reload table view with single sections containig provider rows
	/// - Parameter rows: new table view rows
	func reload(with rows: [CellConfigurator])

	/// Reload table view with single sections containig provider rows
	/// - Parameters:
	///   - rows: new table view rows
	///   - reloadRule: update table rule
	func reload(with rows: [CellConfigurator], reloadRule: TableDirector.ReloadRule)

	/// Reload table view with single sections containig provider rows
	/// - Parameters:
	///   - rows: new table view rows
	///   - reloadRule: update table rule
	///   - animated: should use table view default animation
	func reload(with rows: [CellConfigurator], reloadRule: TableDirector.ReloadRule, animated: Bool)

	/// Got index path of cell if it exist in table view
	/// - Parameter cell: table cell to find indexPath
	func indexPath(for cell: UITableViewCell) -> IndexPath?

	/// Add view that weill be shown if table content is empty
	/// TableDirector will retatin view, so keep it in mind
	/// - Parameters:
	///   - viewFactory: function that creates view. Called on main thread only
	///   - position: information how to place view inside table view
	func addEmptyStateView(viewFactory: @escaping () -> UIView, position: TableDirector.CoverView.Position)

	/// Clear current table content and show info view with settings
	/// If will replace empty view if there is any in table
	/// - Parameters:
	///   - viewFactory: function that creates view. Called on main thread only
	///   - position: information how to place view inside table view
	func clearAndShowView(viewFactory: @escaping () -> UIView, position: TableDirector.CoverView.Position)
}

// MARK: - Default implementation
extension TableDirectorInput {
	/// Reload table view animated with provided sections
	/// - Parameter sections: new table sections
	public func reload(with sections: [TableSection]) {
		reload(with: sections, reloadRule: .fullReload)
	}

	/// Reload table view animated with single section with provided rows
	/// - Parameter rows: new table rows
	public func reload(with rows: [CellConfigurator]) {
		reload(with: rows, reloadRule: .fullReload)
	}

	/// Reload table view animated with single sections containig provider rows
	/// - Parameters:
	///   - rows: new table view rows
	///   - reloadRule: update table rule
	public func reload(with rows: [CellConfigurator], reloadRule: TableDirector.ReloadRule) {
		reload(with: rows, reloadRule: reloadRule, animated: true)
	}

	/// Reload table view animated with provided sections
	/// - Parameters:
	///   - sections: new table sections
	///   - reloadRule: update table rule
	public func reload(with sections: [TableSection], reloadRule: TableDirector.ReloadRule) {
		reload(with: sections, reloadRule: reloadRule, animated: true)
	}
}
