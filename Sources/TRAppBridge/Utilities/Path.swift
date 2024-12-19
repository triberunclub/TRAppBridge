//
//  Path.swift
//  TRAppBridge
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation

public struct Path {
	// MARK: Stored Properties

	public var pathComponents: [String]
	public var queryParameters: [String: String]

	// MARK: Init

	public init(
		pathComponents: [String] = [],
		queryParameters: [String: String] = [:]
	) {
		self.pathComponents = pathComponents
		self.queryParameters = queryParameters
	}

	// MARK: Implementations

	public func appendToURL(_ baseURL: String) -> URL? {
		var urlString = baseURL

		if !pathComponents.isEmpty {
			urlString += "//\(pathComponents.joined(separator: "/"))"
		}

		guard var components = URLComponents(string: urlString) else { return nil }

		if !queryParameters.isEmpty {
			components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		}

		return components.url
	}
}
