//
//  TableRow.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

// We need geenric CellType - we gonna take all information from there.
// Also we should check if CellType is tableViewCell. Our protocol can be used for collectionView also
public final class TableRow<CellType: ConfigurableCell>: CellConfigurator where CellType: UITableViewCell {
	public var cellClass: UITableViewCell.Type { return CellType.self }

	public let item: CellType.ViewModel

	public private(set) var viewHeight: CGFloat?
	public private(set) var diffableItem: DiffInformation = .randomItem

	public init(item: CellType.ViewModel) {
		self.item = item
	}

	public convenience init(item: CellType.ViewModel, height: CGFloat) {
		self.init(item: item)
		self.viewHeight = height
	}

	public convenience init(item: CellType.ViewModel, heightCalculatable: HeightCalculatable) {
		self.init(item: item)
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
		cellWithType.configure(item)
	}
}

// MARK: - CellType.ViewModel: Equatable
extension TableRow where CellType.ViewModel: ViewModelDiffable {
	public convenience init(item: ViewModelDiffable) {
		self.init(item: item)
		diffableItem = DiffInformation(diffId: item.diffId, diffableKeys: item.diffableKeys)
	}

	public convenience init(item: ViewModelDiffable, height: CGFloat) {
		self.init(item: item)
		diffableItem = DiffInformation(diffId: item.diffId, diffableKeys: item.diffableKeys)
		self.viewHeight = height
	}

	public convenience init(item: ViewModelDiffable, heightCalculatable: HeightCalculatable) {
		self.init(item: item)
		diffableItem = DiffInformation(diffId: item.diffId, diffableKeys: item.diffableKeys)
		viewHeight = heightCalculatable.viewHeight
	}
}
