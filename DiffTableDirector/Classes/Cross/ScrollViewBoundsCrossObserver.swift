//
//  ScrollViewBoundsCrossObserver.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 04.05.2020.
//

import Foundation
import UIKit

final class ScrollViewBoundsCrossObserver {
	// MARK: - Properties
	private let _thresholdCalculator: BaseThresholdCalculator
	private var _boundsObserver: NSKeyValueObservation?
	private var _contentSizeObserver: NSKeyValueObservation?
	private var _contentInsetsObserver: NSKeyValueObservation?

	private var _baseBottomThreshold: CGFloat
	private var _baseTopThreshold: CGFloat

	// MARK: - ScrollViewBoundsCrossObservable
	private unowned var _scrollView: UIScrollView!

	var overBottomBounds: Bool = false
	var overTopBounds: Bool = false

	var bottomCrossObserver: ThresholdCrossObserver?
	var topCrossObserver: ThresholdCrossObserver?

	var bottomThreshold: CGFloat {
		return _baseBottomThreshold
	}

	var topThreshold: CGFloat {
		return _baseTopThreshold
	}

	// MARK: - Init
	init(scrollView: UIScrollView, thresholdCalculator: BaseThresholdCalculator = BaseThresholdCalculator()) {
		self._scrollView = scrollView
		self._thresholdCalculator = thresholdCalculator

		self._baseBottomThreshold = thresholdCalculator.calculateBaseBottomThreshold(for: scrollView)
		self._baseTopThreshold = thresholdCalculator.calculateBaseTopThreshold(for: scrollView)

		self._boundsObserver = createContentOffsetObserver()

		_observeContentSizeChanges()
		_observeContentInsetChanges()
	}

	// MARK: - Observing
	private func _observeContentSizeChanges() {
		_contentSizeObserver = scrollView.createContentSizeObserver(hanlder: { [unowned self] _ in
			self._baseBottomThreshold = self._thresholdCalculator.calculateBaseBottomThreshold(for: self.scrollView)
		})
	}

	private func _observeContentInsetChanges() {
		_contentInsetsObserver = scrollView.createContentInsetsObserver(hanlder: { [unowned self] _ in
			self._baseTopThreshold = self._thresholdCalculator.calculateBaseTopThreshold(for: self.scrollView)
			self._baseBottomThreshold = self._thresholdCalculator.calculateBaseBottomThreshold(for: self.scrollView)
		})
	}
}

// MARK: - ScrollViewBoundsCrossObservable
extension ScrollViewBoundsCrossObserver: ScrollViewBoundsCrossObservable {
	var scrollView: UIScrollView {
		return _scrollView
	}
}

// MARK: - Create observers
extension UIScrollView {
	func createScrollObserver(hanlder: @escaping ((CGPoint) -> Void)) -> NSKeyValueObservation {
		return observe(\UIScrollView.contentOffset, options: [.new]) { (_, changes) in
			guard let newValue = changes.newValue else { return }
			hanlder(newValue)
		}
	}

	func createContentSizeObserver(hanlder: @escaping ((CGSize) -> Void)) -> NSKeyValueObservation {
		return observe(\UIScrollView.contentSize, options: [.new]) { (_, changes) in
			guard let newValue = changes.newValue else { return }
			hanlder(newValue)
		}
	}

	func createContentInsetsObserver(hanlder: @escaping ((UIEdgeInsets) -> Void)) -> NSKeyValueObservation {
		return observe(\UIScrollView.contentInset, options: [.new]) { (_, changes) in
			guard let newValue = changes.newValue else { return }
			hanlder(newValue)
		}
	}
}
