//
//  PaginationController.PrefetchStraregy.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 23.05.2020.
//

import Foundation

extension PaginationController {
	public enum PrefetchStrategy {
		case none
		case system
		case custom((UITableView) -> Bool)
	}
}
