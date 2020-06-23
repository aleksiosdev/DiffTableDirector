//
//  CellConfigurator.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

/// Configure cell 
public protocol CellConfigurator {
	var cellClass: UITableViewCell.Type { get }
	var hashableViewModel: AnyHashable { get }
	var viewHeight: CGFloat? { get }

	func configure(cell: UITableViewCell)
}
