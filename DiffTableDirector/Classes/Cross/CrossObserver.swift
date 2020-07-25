//
//  CrossObserver.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 04.05.2020.
//

import Foundation
import UIKit

/// Observe bount of scroll view with provided offset
public struct CrossObserver {
	public let didCross: () -> Void
	public let didReturn: () -> Void
	public let crossBoundOffset: ThresholdCrossBoundOffset

	/// Default constructor
	/// - Parameters:
	///   - didCross: callback for cross bounds events
	///   - didReturn: baclback for return to bounds event
	///   - additionalOffset: offset from original bound
	public init(didCross: @escaping () -> Void, didReturn: @escaping () -> Void, offset: ThresholdCrossBoundOffset = .value(offset: 0)) {
		self.didCross = didCross
		self.didReturn = didReturn

		self.crossBoundOffset = offset
	}
}

// MARK: - ThresholdCrossObserver
extension CrossObserver: ThresholdCrossObserver {
	public func scrollViewDidCrossThreshold(scrollView: UIScrollView, offset: CGFloat) {
		didCross()
	}

	public func scrollViewDidReturnUnderThreshold(scrollView: UIScrollView, offset: CGFloat) {
		didReturn()
	}
}
