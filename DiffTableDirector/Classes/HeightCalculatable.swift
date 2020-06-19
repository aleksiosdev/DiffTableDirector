//
//  HeightCalculatable.swift
//  Alamofire
//
//  Created by Aleksandr Lavrinenko on 12.06.2020.
//

import Foundation

/// Can calculate height for view
public protocol HeightCalculatable {
	var viewHeight: CGFloat { get }
}
