//
//  TableDirector.ReloadRule.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

extension TableDirector {
	/// How update table
	public enum ReloadRule {
		/// For iOS 12 perform  table view reloadData method. For iOS 13 and higher apply snapshot
		case fullReload
		/// Calculate diff on main thread, reload updated cells
		case calculateReloadSync
		/// Calculate diff on background thread, reload updated cells
		case calculateReloadAsync(queue: DispatchQueue)
	}
}
