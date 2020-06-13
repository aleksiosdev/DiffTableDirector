//
//  ActionCell.swift
//  TableDirector
//
//  Created by Aleksandr Lavrinenko on 12.04.2020.
//

import Foundation

/// Cell that can send actions to delegate
public protocol ActionCell: ConfigurableCell, TableItemActionable { }
