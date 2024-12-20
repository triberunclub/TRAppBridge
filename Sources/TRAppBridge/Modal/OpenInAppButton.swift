//
//  OpenInAppButton.swift
//  TRAppBridgeExample
//
//  Created by Francesco Leoni on 20/12/24.
//

import SwiftUI

public struct OpenInAppButton<Content: View>: View {

	var id: String
	var apps: [AnyApplication]
	var label: () -> Content
	var perform: (() -> Void)?
	
	@State private var showSheet: Bool = false
	
	public init(id: String, apps: [AnyApplication?], @ViewBuilder label: @escaping () -> Content, perform: (() -> Void)? = nil) {
		self.id = id
		self.apps = apps.compactMap { $0 }
		self.label = label
		self.perform = perform
	}
	
	public var body: some View {
		Button {
			if UserDefaults.standard.bool(forKey: id),
				 let appScheme = TRAppBridge.shared.defaultApp(for: id) {
				apps.first(where: { $0.scheme == appScheme })?.open()
			} else {
				showSheet = true
			}
			
			perform?()
		} label: {
			label()
		}
		.sheet(isPresented: $showSheet) {
			OpenInAppSheet(id: id, apps: apps) { _ in
				showSheet = false
			}
			.presentationDetents([.medium])
		}
	}
}
