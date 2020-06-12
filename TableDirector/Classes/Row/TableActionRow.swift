//
//  TableActionRow.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

public final class TableActionRow<CellType: ActionCell>: CellConfigurator where CellType: UITableViewCell {
	public var cellClass: UITableViewCell.Type { return CellType.self }

	public let viewModel: CellType.ViewModel

	public private(set) var viewHeight: CGFloat?
	public private(set) var diffableItem: DiffInformation = .randomItem

	weak var delegate: AnyObject?

	// Store item and delegate
	public init(viewModel: CellType.ViewModel, delegate: CellType.Delegate) {
		self.viewModel = viewModel
		self.delegate = delegate as AnyObject
	}

	public func configure(cell: UITableViewCell) {
		guard let cellWithType = cell as? CellType else {
			fatalError()
		}
		cellWithType.configure(viewModel)
		cellWithType.delegate = delegate as? CellType.Delegate
	}
}

// MARK: - CellType.ViewModel: Equatable
extension TableActionRow where CellType.ViewModel: ViewModelDiffable {
	public convenience init(diffViewModel: CellType.ViewModel, delegate: CellType.Delegate) {
		self.init(viewModel: diffViewModel, delegate: delegate)
		diffableItem = DiffInformation(diffId: diffViewModel.diffId, diffableKeys: diffViewModel.diffableKeys)
	}

	public convenience init(item: CellType.ViewModel, delegate: CellType.Delegate, height: CGFloat) {
		self.init(viewModel: item, delegate: delegate)
		diffableItem = DiffInformation(diffId: item.diffId, diffableKeys: item.diffableKeys)
		self.viewHeight = height
	}

	public convenience init(item: CellType.ViewModel, delegate: CellType.Delegate, heightCalculatable: HeightCalculatable) {
		self.init(viewModel: item, delegate: delegate)
		diffableItem = DiffInformation(diffId: item.diffId, diffableKeys: item.diffableKeys)
		viewHeight = heightCalculatable.viewHeight
	}
}
