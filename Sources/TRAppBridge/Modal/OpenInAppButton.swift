//
//  OpenInAppButton.swift
//  TRAppBridgeExample
//
//  Created by Francesco Leoni on 20/12/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct OpenInAppButton<Content: View>: View {

	// MARK: Stored Properties

	var id: SheetIdentifier
	var apps: [AnyApplication]
	var label: () -> Content
	var perform: (() -> Void)?

	// MARK: Wrapped Properties

	@State private var showSheet: Bool = false

	// MARK: Init

	public init(
		id: SheetIdentifier,
		apps: [AnyApplication?],
		@ViewBuilder label: @escaping () -> Content,
		perform: (() -> Void)? = nil
	) {
		self.id = id
		self.apps = apps.compactMap { $0 }
		self.label = label
		self.perform = perform
	}

	public init(
		id: SheetIdentifier,
		actionGroup: ActionGroup,
		@ViewBuilder label: @escaping () -> Content,
		perform: (() -> Void)? = nil
	) {
		self.init(id: id, apps: actionGroup.apps, label: label, perform: perform)
	}

	// MARK: Body

	public var body: some View {
		Button {
			if UserDefaults.standard.bool(forKey: id),
				 let appScheme = TRAppBridge.shared.defaultApp(for: id),
				 let app = apps.first(where: { $0.scheme == appScheme }) {
				app.open()
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
