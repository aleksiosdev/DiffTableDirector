//
//  TableHeader.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import Foundation

/// Configure provided header with view model
public class TableHeader<HeaderType: ConfigurableHeaderFooter>: HeaderConfigurator
where HeaderType: UITableViewHeaderFooterView {
	public var viewClass: UITableViewHeaderFooterView.Type { return HeaderType.self }

	public private(set) var diffableItem: DiffInformation = .randomItem
	public let item: HeaderType.ViewModel

	public private(set) var viewHeight: CGFloat?

	public init(item: HeaderType.ViewModel) {
		self.item = item
	}

	convenience init(item: HeaderType.ViewModel, height: CGFloat) {
		self.init(item: item)
		self.viewHeight = height
	}

	convenience init(item: HeaderType.ViewModel, heightCalculatable: HeightCalculatable) {
		self.init(item: item)
		self.viewHeight = heightCalculatable.viewHeight
	}

	public func configure(view: UITableViewHeaderFooterView) {
		guard let viewWithType = view as? HeaderType else {
			fatalError()
		}
		viewWithType.configure(item)
	}
}
