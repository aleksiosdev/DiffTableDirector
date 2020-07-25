//
//  BaseThresholdCalculator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 05.05.2020.
//

import Foundation
import UIKit

struct BaseThresholdCalculator {
	func calculateBaseTopThreshold(for scrollView: UIScrollView) -> CGFloat {
		return scrollView.contentInset.top
	}

	func calculateBaseBottomThreshold(for scrollView: UIScrollView) -> CGFloat {
		let bottomThreshold = scrollView.contentSize.height - scrollView.frame.height + scrollView.contentInset.bottom
		if bottomThreshold < 0 {
			return 0
		}
		return bottomThreshold
	}
}
