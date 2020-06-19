//
//  DispatchQueue+Extensions.swift
//  Alamofire
//
//  Created by Aleksandr Lavrinenko on 13.06.2020.
//

import Foundation

extension DispatchQueue {
	static func asyncOnMainIfNeeded(_ callback: @escaping () -> Void) {
		if Thread.current.isMainThread {
			callback()
		} else {
			DispatchQueue.main.async {
				callback()
			}
		}
	}
}
