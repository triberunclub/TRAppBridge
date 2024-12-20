//
//  ActionPaths.swift
//  TRAppBridge
//
//  Created by Luigi Aiello on 10/10/24.
//

import Foundation

public struct ActionPaths {
	// MARK: Stored Properties

	public var app: Path
	public var web: Path

	// MARK: Init

	public init(
		app: Path = Path(),
		web: Path = Path()
	) {
		self.app = app
		self.web = web
	}
}
