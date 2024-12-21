//
//  Outlook.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import Foundation

public struct Outlook: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Outlook"
	public var icon: String = "outlook"
	public let scheme = "ms-outlook://"
	public let fallbackURL = "https://www.outlook.com/"
	public let appStoreId = "951937596"

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open
		case send(recipient: String, subject: String, body: String)

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: ["app"]
					)
				)

			case let .send(recipient, subject, body):
				return ActionPaths(
					app: Path(
						pathComponents: ["compose"],
						queryParameters: ["to": recipient,
															"subject": subject,
															"body": body]
					)
				)
			}
		}
	}
}
