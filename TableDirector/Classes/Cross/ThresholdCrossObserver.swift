//
//  CrossObserver.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 04.05.2020.
//

import Foundation

/// Handle cross events in scroll view
public protocol ThresholdCrossObserver {
	/// Offset from base bound border
	var crossBoundOffset: ThresholdCrossBoundOffset { get }

	/// Did cross top thresold
	/// - Parameters:
	///   - scrollView: scroll view
	///   - offset: scroll view offset
	func scrollViewDidCrossThreshold(scrollView: UIScrollView, offset: CGFloat)

	/// Did return under thresold
	/// - Parameters:
	///   - scrollView: scroll view
	///   - offset: scroll view offset
	func scrollViewDidReturnUnderThreshold(scrollView: UIScrollView, offset: CGFloat)
}

/// Where should cross bound trigger
public enum ThresholdCrossBoundOffset {
	/// Lower bound will trigger cross event. Upper bound will trigger return event
	case range(range: Range<CGFloat>)
	/// Move bounds cross point to provided value
	case value(offset: CGFloat)
	/// Point equal to original bound
	case bound

	var crossOffset: CGFloat {
		switch self {
		case .range(let range):
			return range.lowerBound
		case .value(let offset):
			return offset
		case .bound:
			return 0
		}
	}

	var returnOffset: CGFloat {
		switch self {
		case .range(let range):
			return range.upperBound
		case .value(let offset):
			return offset
		case .bound:
			return 0
		}
	}
}
