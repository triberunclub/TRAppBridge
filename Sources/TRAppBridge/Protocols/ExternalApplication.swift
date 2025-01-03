import Foundation

/// Represents an external application that can be opened via URL scheme.
public protocol ExternalApplication {
	
	associatedtype ActionType: ExternalApplicationAction

	/// The name of the application.
	var name: String { get }

	/// The icon of the application.
	var icon: String { get }

	/// The URL scheme used to open the application.
	var scheme: String { get }

	/// The fallback URL to open in a web browser if the app is not installed.
	var fallbackURL: String { get }

	/// The App Store ID for the application, used to direct users to download the app if it's not installed.
	var appStoreId: String { get }

	init()
}
