//
//  Waze.swift
//  TRAppBridgeExample
//
//  Created by Francesco Leoni on 20/12/24.
//

import Foundation

public struct Waze: ExternalApplication {

	// MARK: Stored Properties

	public typealias ActionType = Action

	public var name: String = "Waze"
	public var icon: String = "waze"
	public let scheme = "waze"
	public let fallbackURL = "https://www.waze.com"
	public let appStoreId = "323229106"

	// MARK: Init

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open
		case navigateToDirection(lat: String, lng: String)

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: ["app"],
						queryParameters: [:]
					),
					web: Path()
				)

			case .navigateToDirection(let lat, let lng):
				return ActionPaths(
					app: Path(
						pathComponents: [""],
						queryParameters: [
							"ll": "\(lat),\(lng)",
							"navigate": "yes",
						]
					),
					web: Path()
				)
			}
		}
	}
}
