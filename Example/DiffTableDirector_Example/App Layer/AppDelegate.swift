//
//  AppDelegate.swift
//  DiffTableDirector
//
//  Created by Aleksandr Lavrinenko on 19.06.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
		-> Bool {
			let window = UIWindow(frame: UIScreen.main.bounds)
			window.makeKeyAndVisible()
			self.window = window

			window.rootViewController = UINavigationController(rootViewController: SelectFeatureViewController())
			return true
	}

	func createStoryboardViewController() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "StoryboardViewController")
	}
}
