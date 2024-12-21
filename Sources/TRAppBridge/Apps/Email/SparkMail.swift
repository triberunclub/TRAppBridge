//
//  SparkMail.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import Foundation

public struct SparkMail: ExternalApplication {

	public typealias ActionType = Action

	public var name: String = "Spark"
	public var icon: String = "spark-mail"
	public let scheme = "readdle-spark://"
	public let fallbackURL = "https://readdle.com/products/spark"
	public let appStoreId = "997102246"

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
						pathComponents: ["mail/compose"],
						queryParameters: ["recipient": recipient,
															"subject": subject,
															"body": body]
					)
				)
			}
		}
	}
}
