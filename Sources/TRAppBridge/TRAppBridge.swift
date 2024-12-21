import Foundation

#if canImport(UIKit)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// Main class for handling deep linking to external applications.
public class TRAppBridge {
	// MARK: Stored Properties

	private var applicationInstances: [String : any ExternalApplication] = [:]

	// MARK: Singleton

	public static let shared = TRAppBridge()

	// MARK: Initialization

	private init() {}

	// MARK: Methods

	public func defaultApp(for id: String) -> String? {
		UserDefaults.standard.string(forKey: id + ".app_to_use")
	}

	public func application<T: ExternalApplication>(_ type: T.Type) -> T {
		let typeName = String(describing: type)

		if let existingInstance = applicationInstances[typeName] as? T {
			return existingInstance
		}

		let newInstance = T()
		applicationInstances[typeName] = newInstance

		return newInstance
	}

	public func isAppInstalled<T: ExternalApplication>(_ appType: T.Type) -> Bool {
		let app = application(appType)

//		var components = URLComponents()
//		components.scheme = app.scheme

		guard let url = URL(string: app.scheme) else {
			return false
		}

#if canImport(UIKit)
		return UIApplication.shared.canOpenURL(url)
#elseif os(macOS)
		return NSWorkspace.shared.canOpenURL(url)
#else
		return false
#endif
	}

	public func open<T: ExternalApplication>(
		_ appType: T.Type,
		action: T.ActionType,
		promptInstall: Bool = false,
		completion: @escaping (Result<Void, TRAppBridgeError>) -> Void
	) {
		let app = application(appType)

		let baseURL = URL(string: app.scheme)
		let paths = action.paths

		// Combine URL logic
		guard let baseURL, isAppInstalled(appType) else {
			handleAppNotInstalled(app: app, promptInstall: promptInstall, completion: completion)
			return
		}

		let new = paths.app.appendToURL(baseURL.absoluteString, scheme: app.scheme) ?? baseURL

		open(url: new, completion: completion)
	}

	private func handleAppNotInstalled<T: ExternalApplication>(
		app: T,
		promptInstall: Bool = false,
		completion: @escaping (Result<Void, TRAppBridgeError>) -> Void
	) {
		if promptInstall, !app.appStoreId.isEmpty {
			open(AppStoreApplication.self, action: .app(id: app.appStoreId), completion: completion)
			return
		}
//		else {
//			completion(.failure(.failedToOpenAppStore))
//			return
//		}

		guard let fallbackUrl = URL(string: app.fallbackURL) else {
			completion(.failure(.invalidFallbackURL))
			return
		}

		open(url: fallbackUrl, completion: completion)
	}

	private func open(url: URL, completion: @escaping (Result<Void, TRAppBridgeError>) -> Void) {
#if canImport(UIKit)
		UIApplication.shared.open(url, options: [:]) { success in
			completion(success ? .success(()) : .failure(.failedToOpenURL))
		}
#elseif os(macOS)
		let success = NSWorkspace.shared.open(url)
		completion(success ? .success(()) : .failure(.failedToOpenURL))
#else
		completion(.failure(.platformNotSupported))
#endif
	}
}
