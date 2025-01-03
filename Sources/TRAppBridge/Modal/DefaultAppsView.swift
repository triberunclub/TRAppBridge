//
//  SwiftUIView.swift
//  Screens
//
//  Created by Francesco Leoni on 02/01/25.
//

import SwiftUI

@available(iOS 16.0, *)
public struct AppOption: Identifiable {

	public var id: String { key }
	public var key: SheetIdentifier
	public var title: String
	public var apps: [BaseApplication]

	public init(key: SheetIdentifier, title: String, apps: [BaseApplication?]) {
		self.key = key
		self.title = title
		self.apps = apps.compactMap { $0 }
	}

	public init(key: SheetIdentifier, title: String, actionGroup: BaseActionGroup) {
		self.key = key
		self.title = title
		self.apps = actionGroup.apps.compactMap { $0 }
	}
}

@available(iOS 16.0, *)
public struct DefaultAppsView: View {

	var options: [AppOption]

	public init(options: [AppOption]) {
		self.options = options
	}

	public var body: some View {
		ScrollView {
			VStack {
				ForEach(options) { option in
					DefaultAppView(option: option)

					Divider()
				}
			}
		}
		.navigationTitle(String(localized: "Default apps", bundle: .module))
		.navigationBarTitleDisplayMode(.inline)
	}
}

@available(iOS 16.0, *)
struct DefaultAppView: View {

	@State var rememberApp: Bool = false
	@State var defaultSelectedAppScheme: String?

	var option: AppOption

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text(option.title)
				.font(.title2)

			if option.apps.isEmpty {
				Text("No application on your phone can perform this action.")
					.padding(.vertical)
					.foregroundStyle(.secondary)
					.multilineTextAlignment(.center)
					.frame(maxWidth: .infinity, alignment: .center)
			} else {
				VStack(spacing: 8) {
					ForEach(option.apps, id: \.scheme) { app in
						Button {
							UserDefaults.standard.set(app.scheme, forKey: option.key + ".app_to_use")
							defaultSelectedAppScheme = app.scheme
						} label: {
							HStack(spacing: 20) {
								Image(app.icon, bundle: .module)
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

								if defaultSelectedAppScheme == app.scheme {
									Image(systemName: "checkmark")
										.font(.title2)
										.padding(.trailing, 8)
										.foregroundStyle(.blue)
								}
							}
							.padding(12)
							.background(.primary.opacity(0.03), in: .rect(cornerRadius: 16))
						}
						.buttonStyle(.plain)
						.disabled(!rememberApp)
					}
				}

				Toggle(String(localized: "Remember the app to use", bundle: .module), isOn: $rememberApp)
					.font(.subheadline)
					.foregroundStyle(.secondary)
			}
		}
		.padding()
		.onAppear {
			rememberApp = UserDefaults.standard.bool(forKey: option.key)
			defaultSelectedAppScheme = UserDefaults.standard.string(forKey: option.key + ".app_to_use")
		}
		.onChange(of: rememberApp) { value in
			UserDefaults.standard.set(value, forKey: option.key)
		}
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		NavigationView {
			DefaultAppsView(options: [AppOption(key: .sendEmailSheetIdentifier, title: "Mail", actionGroup: .sendEmail),
																AppOption(key: .showLocationSheetIdentifier, title: "Navigate", actionGroup: .showLocation)])
		}

	} else {
		Text("")
	}
}
