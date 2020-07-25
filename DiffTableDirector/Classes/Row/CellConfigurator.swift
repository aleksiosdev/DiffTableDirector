//
//  CellConfigurator.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation
import UIKit

/// Configure cell 
public protocol CellConfigurator {
	var cellClass: UITableViewCell.Type { get }
	var hashableModel: AnyHashable? { get }
	var viewHeight: CGFloat? { get }
	var estimatedViewHeight: CGFloat? { get }

	func configure(cell: UITableViewCell)
}
