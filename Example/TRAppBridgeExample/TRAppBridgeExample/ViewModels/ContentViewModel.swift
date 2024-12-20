//
//  ContentViewModel.swift
//  TRAppBridgeExample
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation
import TRAppBridge

@MainActor
class ContentViewModel: ObservableObject {
	// MARK: Stored Properties

	let bridge = TRAppBridge.shared

	// MARK: Wrapped Properties

	@Published var result: String = ""

	// MARK: Methods

	func openFacebook() {
		bridge.open(FacebookApplication.self, action: .open) { result in
			DispatchQueue.main.async {
				switch result {
				case .success:
					self.result = "Opened Facebook successfully"

				case .failure(let error):
					self.result = "Failed to open Facebook: \(error.localizedDescription)"
				}
			}
		}
	}

	func openFacebookProfile() {
		bridge.open(FacebookApplication.self, action: .profile) { result in
			DispatchQueue.main.async {
				switch result {
				case .success:
					self.result = "Opened Facebook profile successfully"

				case .failure(let error):
					self.result = "Failed to open Facebook profile: \(error.localizedDescription)"
				}
			}
		}
	}

	func checkFacebookInstalled() {
		let isInstalled = bridge.isAppInstalled(FacebookApplication.self)
		self.result = isInstalled ? "Facebook is installed" : "Facebook is not installed"
	}
}
