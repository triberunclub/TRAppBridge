//
//  AppStoreApplication.swift
//  TRAppBridge
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation

public struct AppStoreApplication: ExternalApplication {
	// MARK: Stored Properties

	public typealias ActionType = Action
	public let scheme = "itms-apps"
	public let fallbackURL = "http:"
	public let appStoreId = ""

	// MARK: Init

	public init() {}
}

public extension AppStoreApplication {
	public enum Action: ExternalApplicationAction {
		case account(id: String)
		case app(id: String)
		case rateApp(id: String)

		// MARK: Computed Properties

		public var paths: ActionPaths {
			switch self {
			case .account(let id):
				return ActionPaths(
					app: Path(
						pathComponents: ["itunes.apple.com", "developer", "id\(id)"],
						queryParameters: [:]
					)
				)

			case .app(let id):
				return ActionPaths(
					app: Path(
						pathComponents: ["itunes.apple.com", "app","id\(id)"],
						queryParameters: [:]
					)
				)

			case .rateApp(let id):
				return ActionPaths(
					app: Path(
						pathComponents: ["itunes.apple.com", "WebObjects", "MZStore.woa", "wa", "viewContentsUserReviews"],
						queryParameters: [
							"type":"Purple+Software",
							"id":id,
						]
					)
				)
			}
		}
	}
}
