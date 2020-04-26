//
//  TitleHeaderFooterView.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 18.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import TableDirector

final class TitleHeaderFooterView: UITableViewHeaderFooterView {
	private let _titleLabel = UILabel()
	private let _height: CGFloat = 36
	private let _leftRightOffset: CGFloat = 16

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		contentView.addSubview(_titleLabel)

		_titleLabel.translatesAutoresizingMaskIntoConstraints = false
		[
			_titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: _leftRightOffset),
			_titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: _leftRightOffset),
			_titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			_titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			_titleLabel.heightAnchor.constraint(equalToConstant: _height)
			].forEach({ $0.isActive = true })
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}

// MARK: - ConfigurableHeaderFooter
extension TitleHeaderFooterView: ConfigurableHeaderFooter {
	typealias ViewModel = String

	func configure(_ item: ViewModel) {
		_titleLabel.text = item
	}
}