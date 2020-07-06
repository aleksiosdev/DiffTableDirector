# DiffTableDirector

[![CI Status](https://img.shields.io/travis/aleksiosdev/DiffTableDirector.svg?style=flat)](https://travis-ci.org/aleksiosdev/DiffTableDirector)
[![Version](https://img.shields.io/cocoapods/v/DiffTableDirector.svg?style=flat)](https://cocoapods.org/pods/DiffTableDirector)
[![License](https://img.shields.io/cocoapods/l/DiffTableDirector.svg?style=flat)](https://cocoapods.org/pods/DiffTableDirector)
[![Platform](https://img.shields.io/cocoapods/p/DiffTableDirector.svg?style=flat)](https://cocoapods.org/pods/DiffTableDirector)

DiffTableDirector - light abstraction above UITableViewDataSource & Delegate. It allows you to work with table in declarative type-safe manner. Provide a lot of little features that you miss in original table view. 

Under the hood library use native Diff API for iOS 13 and DeppDiff for iOS 11 & 12.

## Features
- [x] Type-safe generic cells, headers and footers
- [x] Autoregister table elements
- [x] Support actions from cell/header/footer via delegate
- [x] Placeholder view for empty table
- [x] Observe table bounds cross
- [x] Easy pagination with your loader and animation
- [x] Update table via diff on main or background queue
- [x] Easy to extend

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 11.0+
Xcode 11.0+
Swift 5.0

## Installation

DiffTableDirector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DiffTableDirector'
```

## Author

aleksiosdev, aleksios@manychat.com

## License

DiffTableDirector is available under the MIT license. See the LICENSE file for more info.
