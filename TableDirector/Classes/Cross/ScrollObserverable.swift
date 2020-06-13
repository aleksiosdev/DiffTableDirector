//
//  ScrollObserverable.swift
//  Alamofire
//
//  Created by Aleksandr Lavrinenko on 07.06.2020.
//

import Foundation

/// Notify about scroll view content offset changes
public protocol ScrollObserverable {
	func scrollViewDidScroll(scrollView: UIScrollView)
}
