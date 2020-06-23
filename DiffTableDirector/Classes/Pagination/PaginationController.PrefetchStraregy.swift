//
//  PaginationController.PrefetchStraregy.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 23.05.2020.
//

import Foundation

extension PaginationController {
	/// Prefet
	public enum PrefetchStrategy {
		/// No prefetching
		case none
		/// Use apple prefetch method. If it provides last - n cell in table - we prefetch
		case base(offsetFromLast: Int)
		/// Custom function calculate if we should prefetch
		case custom((UITableView) -> Bool)
	}
}
