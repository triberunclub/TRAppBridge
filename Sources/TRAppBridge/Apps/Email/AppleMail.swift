//
//  AppleMail.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import Foundation

public struct AppleMail: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Apple Mail"
	public var icon: String = "apple-mail"
	public let scheme = "mailto:"
	public let fallbackURL = ""
	public let appStoreId = "1108187098"

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
						pathComponents: [recipient],
						queryParameters: ["subject": subject,
															"body": body]
					)
				)
			}
		}
	}
}
