//
//  SectionsComporator.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 24.05.2020.
//

import Foundation

struct SectionsComporator {
	@available(iOS 13.0, *)
	func calculateUpdate(newSections: [TableSection]) -> Snapshot {
		var snapshot = NSDiffableDataSourceSnapshot<String, AnyCellConfigurator>()
		let sectionEnumerated = newSections.enumerated()
		let sectionIdentifiers = sectionEnumerated.map({ $0.element.identifier ?? "\($0.offset)" })
		snapshot.appendSections(sectionIdentifiers)
		sectionEnumerated.forEach { index, section in
			guard !section.isEmpty else { return }
			let identifier = sectionIdentifiers[index]
			snapshot.appendItems(section.rows.map { AnyCellConfigurator(cellConfigurator: $0) }, toSection: identifier)
		}
		return snapshot
	}

	func calculateUpdate(oldSections: [TableSection], newSections: [TableSection]) -> CollectionUpdate {
		let sectionsDiff = newSections.count - oldSections.count

		let insertedSections: IndexSet? = sectionsDiff > 0 ?
			IndexSet((0..<sectionsDiff).map({ $0 + oldSections.count })) : nil
		let deletedSections: IndexSet? = sectionsDiff < 0 ?
			IndexSet((0..<abs(sectionsDiff)).map({ $0 + newSections.count })) : nil

		var insertedIndexes: [IndexPath] = []
		var deletedIndexes: [IndexPath] = []
		var reloadedIndexes: [IndexPath] = []
		for (index, section) in newSections.enumerated() {
			guard let oldSection = oldSections[safe: index] else {
				continue
			}
			let comparator = RowsComparator<DiffInfo>(
				old: oldSection.rows.map({ $0.diffInfo }),
				new: section.rows.map({ $0.diffInfo }),
				section: index)
			insertedIndexes += comparator.inserted
			deletedIndexes += comparator.deleted
			reloadedIndexes += comparator.replaced
		}
		return CollectionUpdate(
			reload: .init(rows: reloadedIndexes),
			insert: .init(rows: insertedIndexes, sections: insertedSections),
			delete: .init(rows: deletedIndexes, sections: deletedSections))
	}
}
