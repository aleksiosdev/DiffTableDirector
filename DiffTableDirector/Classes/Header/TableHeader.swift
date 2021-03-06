//
//  TableHeader.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import Foundation
import UIKit

/// Configure provided header with view model
public class TableHeader<HeaderType: ConfigurableHeaderFooter>: HeaderConfigurator
where HeaderType: UITableViewHeaderFooterView {
	public var viewClass: UITableViewHeaderFooterView.Type { return HeaderType.self }
	public private(set) lazy var hashableModel: AnyHashable? = {
		return viewModel as? AnyHashable
	}()
	public private(set) var viewHeight: CGFloat?

	public let viewModel: HeaderType.ViewModel


	public init(viewModel: HeaderType.ViewModel) {
		self.viewModel = viewModel
	}

	public convenience init(viewModel: HeaderType.ViewModel, height: CGFloat) {
		self.init(viewModel: viewModel)
		self.viewHeight = height
	}

	public convenience init(viewModel: HeaderType.ViewModel, heightCalculatable: HeightCalculatable) {
		self.init(viewModel: viewModel)
		self.viewHeight = heightCalculatable.viewHeight
	}

	public func configure(view: UITableViewHeaderFooterView) {
		guard let viewWithType = view as? HeaderType else {
			fatalError()
		}
		viewWithType.configure(viewModel)
	}
}
