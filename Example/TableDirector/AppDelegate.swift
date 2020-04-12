//
//  AppDelegate.swift
//  TableDirector
//
//  Created by aleksiosdev on 04/12/2020.
//  Copyright (c) 2020 aleksiosdev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
		-> Bool {
			let tabBarController = UITabBarController()
			let storyboardViewController = createStoryboardViewController()
			storyboardViewController.tabBarItem = UITabBarItem(title: "Storyboard", image: nil, selectedImage: nil)
			let codeViewController = CodeViewController()
			codeViewController.tabBarItem = UITabBarItem(title: "Code", image: nil, selectedImage: nil)
			tabBarController.setViewControllers([storyboardViewController, codeViewController], animated: false)

			let window = UIWindow(frame: UIScreen.main.bounds)
			window.rootViewController = tabBarController
			window.makeKeyAndVisible()
			self.window = window
			return true
	}

	func createStoryboardViewController() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "StoryboardViewController")
	}
}

