//
//  UITableView.RowAnimation+Extensions.swift
//  Alamofire
//
//  Created by Aleksandr Lavrinenko on 16.06.2020.
//

import UIKit

extension UITableView.RowAnimation {
	var enabled: Bool {
		switch self {
		case .none:
			return false
		default:
			return true
		}
	}
}
