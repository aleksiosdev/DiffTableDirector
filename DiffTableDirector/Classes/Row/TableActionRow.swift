//
//  TableActionRow.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation
import UIKit

/// Configure cell with view model and action delegate
public final class TableActionRow<CellType: ActionCell>: CellConfigurator where CellType: UITableViewCell {
	public var cellClass: UITableViewCell.Type { return CellType.self }

	public let viewModel: CellType.ViewModel
	public private(set) lazy var hashableModel: AnyHashable? = {
		return viewModel as? AnyHashable
	}()
	public private(set) var viewHeight: CGFloat?
	public private(set) var estimatedViewHeight: CGFloat?

	weak var delegate: AnyObject?

	// Store item and delegate
	public init(viewModel: CellType.ViewModel, delegate: CellType.Delegate) {
		self.viewModel = viewModel
		self.delegate = delegate as AnyObject
	}

	public convenience init(
		viewModel: CellType.ViewModel,
		delegate: CellType.Delegate,
		height: CGFloat?,
		estimatedHeight: CGFloat?) {
		self.init(viewModel: viewModel, delegate: delegate)
		self.viewHeight = height
		self.estimatedViewHeight = height ?? estimatedHeight
	}

	public convenience init(
		viewModel: CellType.ViewModel,
		delegate: CellType.Delegate,
		heightCalculatable: HeightCalculatable) {
		self.init(viewModel: viewModel, delegate: delegate)
		self.viewHeight = heightCalculatable.viewHeight
		self.estimatedViewHeight = self.viewHeight
	}

	public func configure(cell: UITableViewCell) {
		guard let cellWithType = cell as? CellType else {
			fatalError()
		}
		cellWithType.configure(viewModel)
		cellWithType.delegate = delegate as? CellType.Delegate
	}
}
