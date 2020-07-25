//
//  ScrollViewCrossObservable.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 04.05.2020.
//

import Foundation
import UIKit

protocol ScrollViewBoundsCrossObservable: class {
	var scrollView: UIScrollView { get }

	var overBottomBounds: Bool { get set }
	var overTopBounds: Bool { get set }

	var bottomThreshold: CGFloat { get }
	var topThreshold: CGFloat { get }

	var bottomCrossObserver: ThresholdCrossObserver? { get set }
	var topCrossObserver: ThresholdCrossObserver? { get set }

	func createContentOffsetObserver() -> NSKeyValueObservation
	func checkTopBound(for newY: CGFloat)
	func checkBottomBound(for newY: CGFloat)
}

// MARK: - Default implementation
extension ScrollViewBoundsCrossObservable {
	func createContentOffsetObserver() -> NSKeyValueObservation {
		scrollView.createScrollObserver { [weak self] (point) in
			self?.checkTopBound(for: point.y)
			self?.checkBottomBound(for: point.y)
		}
	}

	func checkTopBound(for newY: CGFloat) {
		if !overTopBounds && newY < topThreshold + (topCrossObserver?.crossBoundOffset.crossOffset ?? 0) {
			overTopBounds = true
			topCrossObserver?.scrollViewDidCrossThreshold(scrollView: scrollView, offset: newY)
		}
		if overTopBounds && newY >= topThreshold + (topCrossObserver?.crossBoundOffset.returnOffset ?? 0) {
			overTopBounds = false
			topCrossObserver?.scrollViewDidReturnUnderThreshold(scrollView: scrollView, offset: newY)
		}
	}

	func checkBottomBound(for newY: CGFloat) {
		guard scrollView.contentSize.height > scrollView.bounds.height else { return }

		if bottomThreshold > 0 &&
			newY > bottomThreshold + (bottomCrossObserver?.crossBoundOffset.crossOffset ?? 0) &&
			!overBottomBounds {
			bottomCrossObserver?.scrollViewDidCrossThreshold(scrollView: scrollView, offset: newY)
			overBottomBounds = true
		}
		if overBottomBounds &&
			newY <= bottomThreshold + (bottomCrossObserver?.crossBoundOffset.returnOffset ?? 0) &&
			newY > topThreshold {
			overBottomBounds = false
			bottomCrossObserver?.scrollViewDidReturnUnderThreshold(scrollView: scrollView, offset: newY)
		}
	}
}
