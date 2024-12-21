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

	public var queryItems: [URLQueryItem] {
		queryParameters.map { URLQueryItem(name: $0, value: $1) }
	}

	// MARK: Init

	public init(
		pathComponents: [String] = [],
		queryParameters: [String: String] = [:]
	) {
		self.pathComponents = pathComponents
		self.queryParameters = queryParameters
	}

	// MARK: Implementations

	public func appendToURL(_ baseURL: String, scheme: String) -> URL? {
		guard let url = URL(string: baseURL) else {
			return nil
		}

		var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
		urlComponents?.queryItems = queryItems.isEmpty ? nil : queryItems

		var pathComponents = self.pathComponents

		if let firstPath = pathComponents.first, (urlComponents?.host == nil || urlComponents?.host?.isEmpty == true) {
			if scheme.contains("://") == true {
				urlComponents?.host = firstPath
			} else {
				urlComponents?.path = firstPath
			}

			pathComponents = Array(pathComponents.dropFirst())
		}

		if !pathComponents.isEmpty {
			urlComponents?.path += "/" + pathComponents.joined(separator: "/")
		}

		return urlComponents?.url
	}
}
