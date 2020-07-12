//
//  FeedViewModel.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import DiffTableDirector

struct FeedViewModel {
	let diffID: String
	let title: String
	let content: String
	let image: UIImage?
}

extension FeedViewModel: Hashable { }

extension FeedViewModel: HeightCalculatable {
	var viewHeight: CGFloat {
		return 200
	}
}
