//
//  GoogleMaps.swift
//  TRAppBridgeExample
//
//  Created by Francesco Leoni on 20/12/24.
//

import Foundation

public struct GoogleMapsApplication: ExternalApplication {
	// MARK: Stored Properties

	public typealias ActionType = Action

	public var name: String = "Google Maps"
	public var icon: String = "google-maps"
	public let scheme = "comgooglemaps"
	public let fallbackURL = "https://maps.google.com"
	public let appStoreId = "585027354"

	// MARK: Init

	public init() {}

	public enum Action: ExternalApplicationAction {

		case open
		case showDirections(start: String?, end: String, mode: String) // mode: standard o streetview
		case showLocation(center: String, zoom: String, views: String) // views: satellite, traffic o transit
		case search(query: String)

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

			case .showDirections(let start, let end, let mode):
				var params = [
						"daddr": end,
						"directionsmode": mode,
					]

				if let start {
					params["saddr"] = start
				}

				return ActionPaths(
					app: Path(
						pathComponents: [""],
						queryParameters: params
					),
					web: Path(
						pathComponents: [""],
						queryParameters: params
					)
				)

			case .showLocation(let center, let zoom, let views):
				return ActionPaths(
					app: Path(
						pathComponents: [""],
						queryParameters: ["center": center,
															"zoom": zoom,
															"views": views]
					),
					web: Path(
						pathComponents: [""],
						queryParameters: ["center": center,
															"zoom": zoom,
															"views": views]
					)
				)

			case .search(let query):
				return ActionPaths(
					app: Path(
						pathComponents: [""],
						queryParameters: [
							"q": query,
						]
					),
					web: Path(
						pathComponents: [""],
						queryParameters: ["q": query]
					)
				)
			}
		}
	}
}
