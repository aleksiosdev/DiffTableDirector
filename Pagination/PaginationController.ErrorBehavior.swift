//
//  PaginationController.ErrorBehavior.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 23.05.2020.
//

import Foundation

extension PaginationController {
	public enum ErrorBehavior {
		case doNothing
		case scrollBack
	}
}
