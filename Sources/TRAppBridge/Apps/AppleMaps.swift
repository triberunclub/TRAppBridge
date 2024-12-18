//
//  AppleMaps.swift
//  TRAppBridge
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation

public struct AppleMapsApplication: ExternalApplication {
	// MARK: Stored Properties

	public typealias ActionType = Action
	public let scheme = "maps:"
	public let fallbackURL = ""
	public let appStoreId = ""

	// MARK: Init

	public init() {}
}

public extension AppleMapsApplication {
	public enum Action: ExternalApplicationAction {
		case open
		case displayDirections(saddr: String, daddr: String, directionsmode: String)

		// MARK: Computed Properties

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: ["app"]
					)
				)

			case .displayDirections(let saddr, let daddr, let directionsmode):
				return ActionPaths(
					app: Path(
						pathComponents: ["app"],
						queryParameters: [
							"saddr": saddr,
							"daddr": daddr,
							"dirflg": directionsmode,
						]
					)
				)
			}
		}
	}
}
