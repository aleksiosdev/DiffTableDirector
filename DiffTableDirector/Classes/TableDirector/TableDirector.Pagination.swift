//
//  TableDirector.Pagination.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 21.05.2020.
//

import Foundation

extension TableDirector {
	final class Pagination {
		private let _boundsCrossObserver: ScrollViewBoundsCrossObservable

		var topController: PaginationController? {
			didSet {
				_boundsCrossObserver.topCrossObserver = topController
			}
		}
		var bottomController: PaginationController? {
			didSet {
				_boundsCrossObserver.bottomCrossObserver = bottomController
			}
		}

		init(tableView: UITableView) {
			_boundsCrossObserver = ScrollViewBoundsCrossObserver(scrollView: tableView)
		}
	}
}
