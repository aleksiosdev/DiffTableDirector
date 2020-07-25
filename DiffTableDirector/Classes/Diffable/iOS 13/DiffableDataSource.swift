//
//  DiffableDataSource.swift
//  DeepDiff
//
//  Created by Aleksandr Lavrinenko on 30.05.2020.
//

import Foundation
import UIKit

protocol DiffableDataSource {
	func apply(snapshot: Snapshot, animation: UITableView.RowAnimation, completion: @escaping () -> Void)
}
