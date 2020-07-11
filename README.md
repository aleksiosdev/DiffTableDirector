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
    
// or

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

And you are best. Code work, table filled. Easy, safe and all items autoregistred. But wait... what about other pressing on cell and ect? 


## Actions

Actions made by delegates. You can achive same effect with callbacks if you wish

```
extension SuperCell: ActionCell {
	typealias ViewModel = InfoViewModel
	typealias Delegate = CellPressableDelegate

	func configure(_ item: InfoViewModel) {
		// Fill your cell with data here
		_titleLabel.text = item.title
		
		contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedCell)))
	}

	@objc func didPressedCell() {
		delegate?.didPressedCell(self)
	}
	
}
```

And creation of cell will change a little

```
let actionRow = TableActionRow<SuperCell>(viewModel: .init(ID: "uniqIdentifier", title: "Ttile", icon: UIImage(named: "icon"), delegate: self)
tableDirector.reload(with: [actionRow])
```

Same for header) 	

## Placeholder View

Sometimes table is empty and it looks ugly. One of solutions is to add fancy picture for empty state. Let's do it

```swift
import DiffTableKit
tableDirector.addEmptyStateView(viewFactory: { [unowned self] in
			// Called on main thread
			return PlaceholderView()
			}, position: .center)
```

And now you can see your placeholder view align to center when table is empty. When you load some content - it's disappear. 

## Diff

Table can show a lot of different information. It can come separetly. Иetter update table with animation than reload it for several times. 
Apple already provide us UIDiffableDataSource but only for iOS 13. We inspired by it and provide same solution with declarative approach. For iOS 11+)

So we need to do 2 steps:

Step 1: Comnform Hashable protocol for all your ViewModels. Better to provide some uniq id like UUID().uuidString. 

```
struct ViewModel: Hashable {
      let id: String
	... 
}
```

TableDirector will diff model if it's not hashable. But the same model will be different for him. Keep it in mind and better use nonhashable ViewModels for nondiffalbe tables.

For iOS13 each reload will be diffable. You will see animation if you provide animtion true. For false case it will looks like oldschool reloadData.

Also you can manualy trigger diffable reload (for lower iOS for example). On main queue and on your queue. 

```
	func reload(with sections: sections, reloadRule: .calculateSync) // Will calculate diff on main thread. 

	func reload(with sections: sections, reloadRule: .calculateAsync(queue: yourQueue) // Will calculate on queue your provider. Can prevent freeze for big collections
	
```

Keep in mind: Apple recommend reload table only on main or only on backgroun queue. Missing with queues can lead to undefined behaviour.

## Cross bounds

Remember that case when you need to draw shadow on upper view when table if scrolled? Or maybe separator? And hide it in unscrolled state. 

```swift
_tableDirector?.topCrossObserver = CrossObserver(didCross: {
	// Draw your shadow/separator here
}, didReturn: {
	// Hide shadow/separator here
})
```

Same can be done for bottom border. We use it along other project and it's really easy

## Pagination and pull to refresh

By the way. This aproach looks good for pagination! Pagination is always pain in bussness logic. But if you want some custom behaviour or animation - UI can be tricky too. 
So we provide component. It can be configurater. Can controll your view and animate it lifecycle. Like this

```swift
let loader = Loader(view: viewForPagination, animator: yourAnimator)
let bottomPaginationController = PaginationController(
	settings: .bottom,
	loader: yourLoader) { (handler) in
		network.request(...) {
			// Change state of pagination. Also your can call same method on pagination controller
			handler.finished(isSuccessfull: true, canLoadNext: true)
		}
	}
self._tableDirector?.add(paginationController: bottomPaginationController)
```

Loader is simple struct 

```
public struct Loader {
	let view: UIView
	let animator: PaginationControllerLoaderAnimator
}

```

Class that animate your loader should conform PaginationControllerLoaderAnimator.

```
public protocol PaginationControllerLoaderAnimator {
	/// Animate loader base on state
	/// - Parameter state: loader state
	func animate(state: PaginationController.Loader.State)
}

/// Loader states
public enum State {
	case initial
	case loading
	case error
	case success
}
```

Enought to deal with most of cases. The same can be applied for pull to refresh. Just provide up direction for PaginationController


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
