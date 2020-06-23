//
//  HeaderConfigurator.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//

import UIKit

/// Configure Header with view model
public protocol HeaderConfigurator {
	var viewClass: UITableViewHeaderFooterView.Type { get }
	var viewHeight: CGFloat? { get }
	
	var hashableViewModel: AnyHashable { get }

	func configure(view: UITableViewHeaderFooterView)
}

/// Configure Footer with view model
public typealias FooterConfigurator = HeaderConfigurator
