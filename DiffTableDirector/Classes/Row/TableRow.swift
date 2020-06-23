//
//  TableRow.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

/// Configure cell with view model
public final class TableRow<CellType: ConfigurableCell>: CellConfigurator where CellType: UITableViewCell {
	public var cellClass: UITableViewCell.Type { return CellType.self }

	public let viewModel: CellType.ViewModel
	public private(set) lazy var hashableViewModel: AnyHashable = {
		return (viewModel as? AnyHashable) ?? UUID().uuidString as AnyHashable
	}()

	public private(set) var viewHeight: CGFloat?

	public init(viewModel: CellType.ViewModel) {
		self.viewModel = viewModel
	}

	public convenience init(viewModel: CellType.ViewModel, height: CGFloat) {
		self.init(viewModel: viewModel)
		self.viewHeight = height
	}

	public convenience init(viewModel: CellType.ViewModel, heightCalculatable: HeightCalculatable) {
		self.init(viewModel: viewModel)
		self.viewHeight = heightCalculatable.viewHeight
	}

	/// Сonfigure cell with view model
	/// - Parameter cell: cell to configurate
	public func configure(cell: UITableViewCell) {
		// This check is more for compilator - cause we use this object to ger reuseID.
		// Out cell, that UITableViewDataSource will provide always conformed to CellType
		guard let cellWithType = cell as? CellType else {
			fatalError()
		}
		cellWithType.configure(viewModel)
	}
}
