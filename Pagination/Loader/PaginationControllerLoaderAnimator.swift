//
//  PaginationControllerLoaderAnimator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 10.05.2020.
//

import Foundation

public protocol PaginationControllerLoaderAnimator {
	func animate(state: PaginationController.Loader.State)
}
