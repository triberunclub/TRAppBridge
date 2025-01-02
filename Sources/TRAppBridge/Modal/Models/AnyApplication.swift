//
//  File.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 02/01/25.
//

import Foundation

public struct AnyApplication: Identifiable {

	// MARK: Stored Properties

	public var id: String { name }
	var name: String
	var icon: String
	var scheme: String
	var open: () -> Void

	// MARK: Init

	public init?<T: ExternalApplication>(
		_ app: T,
		action: T.ActionType,
		completion: ((Result<Void, TRAppBridgeError>) -> Void)? = nil
	) {
		if !TRAppBridge.shared.isAppInstalled(T.self) {
			return nil
		}

		self.name = app.name
		self.icon = app.icon
		self.scheme = app.scheme
		self.open = {
			TRAppBridge.shared.open(T.self, action: action) { result in
				completion?(result)
			}
		}
	}
}
