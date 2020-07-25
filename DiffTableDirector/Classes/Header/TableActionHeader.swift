//
//  TableActionHeader.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 01.05.2020.
//

import Foundation
import UIKit

/// Configure header with view model and action delegate
public final class TableActionHeader<HeaderType: ActionHeader>: HeaderConfigurator
where HeaderType: UITableViewHeaderFooterView {
	public private(set) lazy var hashableModel: AnyHashable? = {
		return viewModel as? AnyHashable
	}()
	public private(set) var viewHeight: CGFloat?

	public var viewClass: UITableViewHeaderFooterView.Type { return HeaderType.self }

	var viewModel: HeaderType.ViewModel
	// Delegate must be weak or we gonna have big memory issue
	weak var delegate: AnyObject?

	// Store item and delegate
	public init(viewModel: HeaderType.ViewModel, delegate: HeaderType.Delegate) {
		self.viewModel = viewModel
		// Here is some hack that I'll expalin under code
		self.delegate = delegate as AnyObject
	}

	public func configure(view: UITableViewHeaderFooterView) {
		guard let viewWithType = view as? HeaderType else {
			fatalError()
		}
		viewWithType.configure(viewModel)
		// Put Delegate inside
		viewWithType.delegate = delegate as? HeaderType.Delegate
	}
}
