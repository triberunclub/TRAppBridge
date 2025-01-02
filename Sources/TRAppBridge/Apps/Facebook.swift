//
//  FacebookApplication.swift
//  TRAppBridge
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation

public struct Facebook: ExternalApplication {
	// MARK: Stored Properties

	public typealias ActionType = Action
	public var name: String = "Facebook"
	public var icon: String = "facebook"
	public let scheme = "fb://"
	public let fallbackURL = "https://www.facebook.com"
	public let appStoreId = "284882215"

	// MARK: Init

	public init() {}

	public enum Action: ExternalApplicationAction {
		case open
		case profile
		case notifications
		case feed
		case page(String)
		case event(String)

		// MARK: Computed Properties

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(pathComponents: [])
				)

			case .profile:
				return ActionPaths(
					app: Path(pathComponents: ["profile"])
				)

			case .notifications:
				return ActionPaths(
					app: Path(pathComponents: ["notifications"])
				)

			case .feed:
				return ActionPaths(
					app: Path(pathComponents: ["feed"])
				)

			case .page(let id):
				return ActionPaths(
					app: Path(pathComponents: ["page"], queryParameters: ["id": id]),
					web: Path(pathComponents: [id])
				)

			case .event(let id):
				return ActionPaths(
					app: Path(pathComponents: ["event"], queryParameters: ["id": id]),
					web: Path(pathComponents: [id])
				)
			}
		}
	}
}

public extension AnyApplication {

	static func facebook(action: Facebook.ActionType,
											 completion: ((Result<Void, TRAppBridgeError>) -> Void)? = nil) -> AnyApplication? {
		AnyApplication(Facebook(), action: action, completion: completion)
	}
}
