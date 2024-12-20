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
	public var name: String = "Apple Maps"
	public var icon: String = "apple-maps"
	public let scheme = "maps"
	public let fallbackURL = ""
	public let appStoreId = ""

	// MARK: Init

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open
		case show(address: String)
		case showCoordinates(lat: Double, lng: Double)
		case showDirections(start: String?, end: String, mode: Mode, mapType: MapType? = nil)

		public enum Mode: String {
			case car = "d"
			case foot = "w"
			case publicTransit = "r"
		}

		public enum MapType: String {
			case standard = "m"
			case satellite = "k"
			case hybrid = "h"
			case transit = "r"
		}

		// MARK: Computed Properties

		public var paths: ActionPaths {
			switch self {
			case .open:
				return ActionPaths(
					app: Path(
						pathComponents: ["app"]
					)
				)

			case .show(let address):
				return ActionPaths(
					app: Path(
						pathComponents: ["app"],
						queryParameters: ["address": address]
					)
				)

			case let .showCoordinates(lat, lon):
				return ActionPaths(
					app: Path(
						pathComponents: ["app"],
						queryParameters: ["address": "\(lat),\(lon)"]
					)
				)

			case let .showDirections(start, end, mode, mapType):
				var params = [
					"daddr": end,
					"dirflg": mode.rawValue,
				]

				if let start {
					params["saddr"] = start
				}

				if let mapType {
					params["t"] = mapType.rawValue
				}

				return ActionPaths(
					app: Path(
						pathComponents: ["app"],
						queryParameters: params
					)
				)
			}
		}
	}
}
