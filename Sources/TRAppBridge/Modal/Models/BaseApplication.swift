//
//  BaseApplication.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 02/01/25.
//

import Foundation

public struct BaseApplication: Identifiable {

	// MARK: Stored Properties

	public var id: String { name }
	public var name: String
	public var icon: String
	public var scheme: String

	// MARK: Init

	public init?(anyApplication: AnyApplication?) {
		guard let anyApplication else { return nil }

		self.name = anyApplication.name
		self.icon = anyApplication.icon
		self.scheme = anyApplication.scheme
	}

	public init?<T: ExternalApplication>(_ app: T) {
		if !TRAppBridge.shared.isAppInstalled(T.self) {
			return nil
		}

		self.name = app.name
		self.icon = app.icon
		self.scheme = app.scheme
	}
}
