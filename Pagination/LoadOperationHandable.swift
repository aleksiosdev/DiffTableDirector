//
//  LoadOperationHandable.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 10.05.2020.
//

import Foundation

public protocol LoadOperationHandable {
	func finished(isSuccessfull: Bool, canLoadNext: Bool)
}
