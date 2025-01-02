//
//  YahooMail.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import Foundation

public struct YahooMail: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Yahoo Mail"
	public var icon: String = "yahoo-mail"
	public let scheme = "ymail://"
	public let fallbackURL = "https://mail.yahoo.com"
	public let appStoreId = "577586159"

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open
		case send(recipient: String, subject: String, body: String)

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: []
					)
				)

			case let .send(recipient, subject, body):
				return ActionPaths(
					app: Path(
						pathComponents: ["mail/compose"],
						queryParameters: ["to": recipient,
															"subject": subject,
															"body": body]
					)
				)
			}
		}
	}
}

public extension AnyApplication {

	static func yahooMail(action: YahooMail.ActionType,
												completion: ((Result<Void, TRAppBridgeError>) -> Void)? = nil) -> AnyApplication? {
		AnyApplication(YahooMail(), action: action, completion: completion)
	}
}
