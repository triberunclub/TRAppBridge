//
//  ViewModifiers.swift
//  TRAppBridge
//
//  Created by Francesco Leoni on 21/12/24.
//

import SwiftUI

@available(iOS 16.0, *)
public extension View {

	func open(id: String, apps: Binding<[AnyApplication]?>) -> some View {
		self.sheet(item: apps) { apps in
			OpenInAppSheet(id: id, apps: apps)
				.presentationDetents([.medium])
		}
	}

	func open(id: String, actionGroup: Binding<ActionGroup?>) -> some View {
		self.sheet(item: actionGroup) { action in
			OpenInAppSheet(id: id, actionGroup: action)
				.presentationDetents([.medium])
		}
	}
}

extension Array: @retroactive Identifiable where Element == AnyApplication {

	public var id: String {
		self.map { $0.id }.joined(separator: ".")
	}
}
