//
//  File.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 02/01/25.
//

import Foundation

public struct AppleMailOpener: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Apple Mail"
	public var icon: String = "apple-mail"
	public let scheme = "message://"
	public let fallbackURL = ""
	public let appStoreId = "1108187098"

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: []
					)
				)
			}
		}
	}
}

public extension AnyApplication {

	static func appleMailOpener(action: AppleMailOpener.ActionType,
															completion: ((Result<Void, TRAppBridgeError>) -> Void)? = nil) -> AnyApplication? {
		AnyApplication(AppleMailOpener(), action: action, completion: completion)
	}
}
