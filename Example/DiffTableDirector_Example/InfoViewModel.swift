//
//  InfoViewModel.swift
//  TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import DiffTableDirector

struct InfoViewModel {
	let title: String
	let content: String
	let diffId: String = UUID().uuidString
}

extension InfoViewModel: Hashable { }
