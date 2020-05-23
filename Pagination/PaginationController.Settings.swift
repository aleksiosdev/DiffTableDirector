//
//  PaginationController.Settings.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 23.05.2020.
//

import Foundation

extension PaginationController {
	public struct Settings {
		public let direction: Direction

		public let prefetch: PrefetchStrategy
		public let errorBehavior: ErrorBehavior
		public let loadNext: Availability

		/// Create setttings for pagination controller.
		/// For top pagination we reccomend disable prefetch
		/// - Parameters:
		///   - direction: pagination direction
		///   - prefetch: can prefetch content
		///   - errorBehavior: scroll view behavior after getting error
		///   - loadNext: can load next page
		public init(
			direction: Direction,
			prefetch: PrefetchStrategy,
			errorBehavior: ErrorBehavior = .scrollBack,
			loadNext: Availability = .enabled) {
			self.direction = direction
			self.prefetch = prefetch
			self.errorBehavior = errorBehavior
			self.loadNext = loadNext
		}

		public static let bottom: Settings = .init(direction: .down, prefetch: .system)
		public static let top: Settings = .init(direction: .up, prefetch: .none)
	}
}
