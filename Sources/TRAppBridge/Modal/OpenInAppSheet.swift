//
//  OpenInAppSheet.swift
//  TRAppBridgeExample
//
//  Created by Francesco Leoni on 20/12/24.
//

import SwiftUI

public struct AnyApplication {

	var name: String
	var icon: String
	var scheme: String
	var open: () -> Void

	public init?<T: ExternalApplication>(_ app: T,
																action: T.ActionType,
																completion: ((Result<Void, TRAppBridgeError>) -> Void)? = nil) {
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

public struct OpenInAppSheet: View {

	var id: String
	var apps: [AnyApplication]
	var didTap: ((AnyApplication) -> Void)?

	@State private var rememberApp: Bool = false

	public init(id: String, apps: [AnyApplication?], didTap: ((AnyApplication) -> Void)? = nil) {
		self.id = id
		self.apps = apps.compactMap { $0 }
		self.didTap = didTap
	}

	public var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text("Open with", bundle: .main)
				.font(.title2)

			VStack(spacing: 8) {
				ForEach(apps, id: \.scheme) { app in
					Button {
						if rememberApp {
							UserDefaults.standard.set(app.scheme, forKey: id + ".app_to_use")
						}

						app.open()
						didTap?(app)
					} label: {
						HStack(spacing: 20) {
							Image(app.icon)
								.resizable()
								.scaledToFit()
								.frame(width: 50, height: 50)
								.clipShape(.rect(cornerRadius: 12))
								.background(.gray, in: .rect(cornerRadius: 12))
								.overlay {
									RoundedRectangle(cornerRadius: 12)
										.stroke(.primary.opacity(0.05), lineWidth: 0.5)
								}

							VStack(alignment: .leading) {
								Text(app.name)
									.bold()
							}
							.frame(maxWidth: .infinity, alignment: .leading)

							Image(systemName: "chevron.right")
								.bold()
								.padding(.trailing, 8)
						}
						.padding(12)
						.background(.primary.opacity(0.03), in: .rect(cornerRadius: 16))
					}
					.buttonStyle(.plain)
				}
			}

			Toggle(String(localized: "Remember the app to use"), isOn: $rememberApp)
				.font(.footnote)
				.foregroundStyle(.secondary)

			Spacer()
		}
		.padding()
		.onAppear {
			rememberApp = UserDefaults.standard.bool(forKey: id)
		}
		.onChange(of: rememberApp) { value in
			UserDefaults.standard.set(value, forKey: id)
		}
	}
}
