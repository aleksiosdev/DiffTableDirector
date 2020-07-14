//
//  SelectFeatureViewController.swift
//  DiffTableDirector_Example
//
//  Created by Aleksandr Lavrinenko on 12.07.2020.
//  Copyright © 2020 Aleksandr Lavrinenko. All rights reserved.
//

import UIKit

final class SelectFeatureViewController: UIViewController {
	// MARK: - UI
	private let _stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.spacing = 16
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		return stackView
	}()

	private let _titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
		titleLabel.text = "Select feature from list to check it out!"
		titleLabel.numberOfLines = 0
		titleLabel.textAlignment = .center
		return titleLabel
	}()

	// MARK: - Init
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Features"

		view.backgroundColor = .white
		view.addSubview(_stackView)

		_stackView.addArrangedSubview(_titleLabel)
		_stackView.translatesAutoresizingMaskIntoConstraints = false

		_stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
		_stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		_stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		_stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -32).isActive = true

		_createFeatureButtons(_createFeatureButtonViewModels(), navigationController: navigationController)
			.forEach({ _stackView.addArrangedSubview($0) })
	}

	// MARK: - Helper
	private func _createFeatureButtonViewModels() -> [ButtonViewModel] {
		return [
			ButtonViewModel(title: "Base usage (code)", actionBlock: {
				return CodeViewController()
			}),
			ButtonViewModel(title: "Base usage (storyboard)", actionBlock: {
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				return storyboard.instantiateViewController(identifier: "StoryboardViewController")
			}),
			ButtonViewModel(title: "Pagination", actionBlock: {
				return BottomPaginationController()
			}),
			ButtonViewModel(title: "Pull to refresh", actionBlock: {
				return PullTotRefreshController()
			}),
			ButtonViewModel(title: "Cross bounds observing", actionBlock: {
				return DropShadowViewController()
			}),
			ButtonViewModel(title: "Error View", actionBlock: {
				return CoverViewController()
			}),
			ButtonViewModel(title: "Diff", actionBlock: {
				return DiffViewController()
			}),
		]
	}

	private func _createFeatureButtons(
		_ buttonViewModels: [ButtonViewModel],
		navigationController: UINavigationController?) -> [UIButton] {
		return buttonViewModels.map { viewModel in
			let button = TouchAppButton { [weak navigationController] in
				navigationController?.pushViewController(viewModel.actionBlock(), animated: true)
			}
			button.setTitle(viewModel.title, for: .normal)
			return button
		}
	}
}

fileprivate struct ButtonViewModel {
	let title: String
	let actionBlock: () -> UIViewController
}
