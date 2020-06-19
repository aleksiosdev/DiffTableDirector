//
//  FeedCell.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import DiffTableDirector

final class FeedCell: UITableViewCell {
	// MARK: - UI
	@IBOutlet weak var contentImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!

}

// MARK: - ConfigurableCell
extension FeedCell: ConfigurableCell {
	typealias ViewModel = FeedViewModel

	func configure(_ item: FeedViewModel) {
		contentImageView.image = item.image
		titleLabel.text = item.title
		contentLabel.text = item.content
	}
}
