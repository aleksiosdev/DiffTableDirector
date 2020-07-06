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

## Usage

Create TableDirector
```swift
import DiffTableKit

let tableDirector = TableDirector(tableView: awesomeTableView)
    or

let tableDirector = TableDirector()
// Later 
tableDirector.connect(to: awesomeTableView)
```

Support Configurable protocol for cell 

```swift
import DiffTableKit

// MARK: - ConfigurableCell
extension SuperCell: ConfigurableCell  {
	struct ViewModel: Hashable {
    let ID: String 
		let name: String
		let icon: UIImage
	}

	func configure(_ item: ViewModel) {
		_nameLabel.text = item.name
		_iconImageView.set(image: item.icon)
	}
}

// MARK: - ConfigurableHeaderFooter
extension SuperHeader: ConfigurableHeaderFooter {
	typealias ViewModel = String

	func configure(_ item: ViewModel) {
		_titleLabel.text = item
	}
}
```

Fill your table

```swift
import DiffTableKit

let row = TableRow<SuperCell>(item: .init(ID: "uniqIdentifier", title: "Ttile", icon: UIImage(named: "icon"))
let header = TableHeader(item: "Header title")
let section = TableSection(rows: [row], headerConfigurator: header)
tableDirector.reload(with: [section])

```

And you are best. Code work, table filled. Easy, safe and all items autoregistred. But wait... what about other features? 


## Placeholder View

Sometimes table is empty and it looks ugly. One of solutions is to add fancy picture for empty state. Let's do it

```swift
import DiffTableKit
tableDirector.addEmptyStateView(viewFactory: { [unowned self] in
			return PlaceholderView()
			}, position: .center)
```

And now you can see your placeholder view align to center when table is empty. When you load some content - it's disappear. 

## Diff

Table can show a lot of different information. It can come separetly. It's better update table with animation than reload it for several times. 
Apple already provide us UIDiffableDataSource for iOS 13. 

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

DiffTableDirector is available under the Apache-2.0 License. See the [license](LICENSE) file for more info.
