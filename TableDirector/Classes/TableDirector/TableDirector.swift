//
//  TableDirector.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import UIKit

// We have to inheritance NSObject - tableView delegates require it
/// Perform all work with table view
public final class TableDirector: NSObject {
	private let _coverController: CoverView.Controller
	private let _sectionsComporator: SectionsComporator
	private var _sections: [TableSection] = [] {
		didSet {
			_changeCoverViewVisability(isSectionsEmpty: _sections.isEmpty)
		}
	}

	private var _diffableDataSourcce: DiffableDataSource?
	private var _defaultCoverViewShowParams: CoverView.ShowParams?
	private var _canShowEmptyView: Bool = true
	private var _registrator: Registrator?
	private lazy var pagination: Pagination? = {
		guard let tableView = _tableView else { return nil }
		return Pagination(tableView: tableView)
	}()

	// We need access to table view to perform some task. Object responsible for UI will retain table view
	public weak var _tableView: UITableView? {
		didSet {
			guard let tableView = _tableView else {
				_registrator = nil
				return
			}
		}
	}

	// Give us ability to switch off self registration
	public var isSelfRegistrationEnabled: Bool

	public var scrollObserable: ScrollObserverable? 

	public var topCrossObserver: ThresholdCrossObserver? {
		didSet {
			_boundsCrossObserver?.topCrossObserver = topCrossObserver
		}
	}
	public var bottomCrossObserver: ThresholdCrossObserver? {
		didSet {
			_boundsCrossObserver?.bottomCrossObserver = bottomCrossObserver
		}
	}

	private lazy var _boundsCrossObserver: ScrollViewBoundsCrossObservable? = {
		guard let tableView = _tableView else { return nil }
		return ScrollViewBoundsCrossObserver(scrollView: tableView)
	}()

	/// Create instance with table view
	/// - Parameter tableView: table view to controll
	public init(tableView: UITableView? = nil, isSelfRegistrationEnabled: Bool = true) {
		self._tableView = tableView
		self._coverController = CoverView.Controller()
		self._sectionsComporator = SectionsComporator()
		self.isSelfRegistrationEnabled = isSelfRegistrationEnabled

		super.init()

		guard let tableView = tableView else { return }
		connect(to: tableView)
	}

	// MARK: - Table view settings
	private func _setDataSourceAndDelegate(for tableView: UITableView) {
		if #available(iOS 13.0, *) {
			_diffableDataSourcce = DiffableTableViewDataSource(tableView: tableView, cellProvider: _createCell)
		} else {
			tableView.dataSource = self
		}
		tableView.delegate = self
	}

	private func _setupEstimatedHeight(for tableView: UITableView) {
		// We need to provide some height or in case your return automaticDimension height for header/footer
		// viewForHeaderInSection/viewForFooterInSection won't trigger
		tableView.estimatedSectionFooterHeight = 1
		tableView.estimatedSectionHeaderHeight = 1

		// Providing base extimate height for rows remove lags in scroll indicator and increase performance
		tableView.estimatedRowHeight = 1
	}

	private func createBoundsCroseObserver(for tableView: UITableView) -> ScrollViewBoundsCrossObservable {
		return ScrollViewBoundsCrossObserver(scrollView: tableView)
	}

	private func _changeCoverViewVisability(isSectionsEmpty: Bool) {
		if let coverViewParams = _defaultCoverViewShowParams,
			let tableView = _tableView,
			isSectionsEmpty,
			_canShowEmptyView {
			_coverController.add(
				view: coverViewParams.coverView,
				to: tableView,
				position: coverViewParams.position)
			return
		}
		_coverController.hide()
	}

	// MARK: - Reload
	private func _fullReload(animated: Bool) {
		if #available(iOS 13.0, *) {
			return _reload(with: _sections, animated: animated)
		}
		_tableView?.reloadData()
	}

	private func _reload(with sections: [TableSection], animated: Bool) {
		if #available(iOS 13.0, *) {
			let snapshot = _sectionsComporator.calculateUpdate(newSections: sections)
			self._sections = sections
			_diffableDataSourcce?.apply(snapshot: snapshot, animated: animated)
			return
		}
		let update = _sectionsComporator.calculateUpdate(oldSections: _sections, newSections: sections)
		_tableView?.reload(update: update, animated: animated, updateSectionsBlock: {
			self._sections = sections
		})
	}

	// MARK: - Create reusabel views
	private func _createHeaderFooterView(with configurator: HeaderConfigurator, tableView: UITableView) -> UIView? {
		if isSelfRegistrationEnabled {
			_registrator?.registerIfNeeded(headerFooterClass: configurator.viewClass)
		}
		let reuseId = configurator.viewClass.reuseIdentifier
		guard let headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId) else {
			assertionFailure("Probably you forgot to register \(reuseId) in tableView")
			return nil
		}
		configurator.configure(view: headerFooterView)
		return headerFooterView
	}

	private func _createCell(
		tableView: UITableView,
		indexPath: IndexPath,
		anyConfigurator: AnyCellConfigurator)
		-> UITableViewCell? {
		return _cell(in: tableView, indexPath: indexPath, configurator: anyConfigurator.cellConfigurator)
	}

	private func _cell(
		in tableView: UITableView,
		indexPath: IndexPath,
		configurator: CellConfigurator)
		-> UITableViewCell {
		if isSelfRegistrationEnabled {
			_registrator?.registerIfNeeded(cellClass: configurator.cellClass)
		}
		let cell = tableView.dequeueReusableCell(
			withIdentifier: configurator.cellClass.reuseIdentifier,
			for: indexPath)
		configurator.configure(cell: cell)
		return cell
	}
}

// MARK: - TableDirectorInput
extension TableDirector: TableDirectorInput {
	public func connect(to tableView: UITableView) {
		_tableView = tableView

		_registrator = Registrator(tableView: tableView)
		_setDataSourceAndDelegate(for: tableView)
		_setupEstimatedHeight(for: tableView)

		if _boundsCrossObserver?.topCrossObserver != nil || _boundsCrossObserver?.bottomCrossObserver != nil {
			if _boundsCrossObserver == nil {
				_boundsCrossObserver = createBoundsCroseObserver(for: tableView)
				_boundsCrossObserver?.topCrossObserver = topCrossObserver
				_boundsCrossObserver?.bottomCrossObserver = bottomCrossObserver
			}
		}
	}

	public func reload(with sections: [TableSection], reloadRule: TableDirector.ReloadRule, animated: Bool) {
		switch reloadRule {
		case .fullReload:
			_sections = sections
			_fullReload(animated: animated)
		case .calculateReloadSync:
			_reload(with: sections, animated: animated)
		case .calculateReloadAsync(let queue):
			queue.async {
				self._reload(with: sections, animated: animated)
			}
		}
	}

	public func reload(with rows: [CellConfigurator], reloadRule: TableDirector.ReloadRule, animated: Bool) {
		let sections = [TableSection(rows: rows)]
		reload(with: sections, reloadRule: reloadRule, animated: animated)
	}

	public func indexPath(for cell: UITableViewCell) -> IndexPath? {
		return _tableView?.indexPath(for: cell)
	}

	public func add(paginationController: PaginationController) {
		switch paginationController.direction {
		case .up:
			pagination?.topController = paginationController
		case .down:
			pagination?.bottomController = paginationController
		}
		guard let tableView = _tableView else { return }
		paginationController.add(to: tableView)
		paginationController.output = self
		tableView.prefetchDataSource = self
	}

	public func addEmptyStateView(viewFactory: @escaping () -> UIView, position: TableDirector.CoverView.Position) {
		DispatchQueue.main.async {
			let view = viewFactory()

			self._defaultCoverViewShowParams = .init(coverView: view, position: position)
			if self._sections.isEmpty {
				guard let tableView = self._tableView else { return }
				self._coverController.add(view: view, to: tableView, position: position)
			}
		}
	}

	public func clearAndShowView(viewFactory: @escaping () -> UIView, position: TableDirector.CoverView.Position) {
		DispatchQueue.main.async {
			let view = viewFactory()
			guard let tableView = self._tableView else { return }
			defer { self._canShowEmptyView = true }
			self._canShowEmptyView = false
			self._sections = []
			self._fullReload(animated: true)
			self._coverController.add(view: view, to: tableView, position: position)
		}
	}
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension TableDirector: UITableViewDelegate & UITableViewDataSource {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return _sections[section].rows.count
	}

	public func numberOfSections(in tableView: UITableView) -> Int {
		return _sections.count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = _sections[indexPath.section].rows[indexPath.row]
		return _cell(in: tableView, indexPath: indexPath, configurator: item)
	}

	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		// Let's build our cells usining AutoLayout.
		// As alternative it you use frame or smth different - you can store height information inside TableRow
		return UITableView.automaticDimension
	}

	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		// Take configurator if threre is any
		guard let configurator = _sections[section].headerView else { return nil }
		return _createHeaderFooterView(with: configurator, tableView: tableView)
	}

	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard let configurator = _sections[section].footerView else { return nil }
		return _createHeaderFooterView(with: configurator, tableView: tableView)
	}

	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		guard _sections[section].headerView != nil else { return 0 }
		return UITableView.automaticDimension
	}

	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		guard _sections[section].footerView != nil else { return 0 }
		return UITableView.automaticDimension
	}

	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		scrollObserable?.scrollViewDidScroll(scrollView: scrollView)
	}
}

extension TableDirector: UITableViewDataSourcePrefetching {
	public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		pagination?.topController?.prefetchIfNeeded(tableView: tableView, indexPaths: indexPaths, sections: _sections)
		pagination?.bottomController?.prefetchIfNeeded(tableView: tableView, indexPaths: indexPaths, sections: _sections)
	}

	public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) { }
}

extension TableDirector: PaginationControllerOutput {
	func scrollToThreshold(direction: PaginationController.Direction, offset: CGFloat) {
		guard let tableView = _tableView else { return }
		let tableHeight = tableView.bounds.height
		let rectSize = CGSize(width: 1, height: tableHeight)
		switch direction {
		case .up:
			let topPoint = CGPoint(x: 0, y: tableView.contentInset.top + offset)
			tableView.scrollRectToVisible(.init(origin: topPoint, size: rectSize), animated: true)
		case .down:
			let yOrigin = tableView.contentSize.height - tableView.contentInset.bottom - tableHeight + offset
			_tableView?.scrollRectToVisible(.init(origin: .init(x: 0, y: yOrigin), size: rectSize), animated: true)
		}
	}

	func changeTopContentInset(newOffset: CGFloat) {
		_tableView?.contentInset.top += newOffset
	}
}
