//
//  FeedModel.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct FeedModel {
	let id: String
	let title: String
	let content: String

	// Model can store a lot of additional properties that view model don't need 
	let isMine: Bool
}
