//
//  GoogleMail.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import Foundation

public struct GoogleMail: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Gmail"
	public var icon: String = "gmail"
	public let scheme = "googlegmail://"
	public let fallbackURL = "https://mail.google.com/"
	public let appStoreId = "422689480"

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
						pathComponents: ["co"],
						queryParameters: ["to": recipient,
															"subject": subject,
															"body": body]
					)
				)
			}
		}
	}
}
