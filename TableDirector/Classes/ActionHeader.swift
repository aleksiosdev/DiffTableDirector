//
//  ActionHeader.swift
//  Pods-TableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 01.05.2020.
//

import Foundation

/// Header that can send actions to delegate
public protocol ActionHeader: ConfigurableHeaderFooter, TableItemActionable { }

/// Footer that can send actions to delegate
public typealias ActionFooter = ActionHeader
