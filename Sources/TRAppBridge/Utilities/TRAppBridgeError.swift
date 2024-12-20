import Foundation

/// Represents errors that can occur when using TRAppBridge.
public enum TRAppBridgeError: Error {
	/// The URL constructed for the app action is invalid.
	/// This may occur if the app's URL scheme is incorrect or if the action parameters are malformed.
	case invalidURL

	/// The requested app is not installed on the device.
	/// This error is thrown when attempting to open an app that isn't present on the user's device.
	case appNotInstalled

	/// The attempt to open the app's URL failed.
	/// This may occur due to system restrictions or if the app is unable to handle the specified action.
	case failedToOpenURL

	/// The attempt to open the fallback URL failed.
	/// This error occurs when the app is not installed and the fallback URL (usually a web URL) also fails to open.
	case failedToOpenFallbackURL

	/// The fallback URL provided for the app is invalid.
	/// This may occur if the ExternalApplication's fallbackURL property is empty or malformed.
	case invalidFallbackURL

	/// The current platform does not support opening URLs.
	/// This error is thrown when trying to open URLs on unsupported platforms (e.g., when UIKit is not available).
	case platformNotSupported

	case failedToOpenAppStore

	/// A human-readable description of the error.
	public var localizedDescription: String {
		switch self {
		case .invalidURL:
			return "The URL for the app action is invalid."

		case .appNotInstalled:
			return "The application is not installed on this device."

		case .failedToOpenURL:
			return "Failed to open the URL. Please ensure the app supports this action."

		case .failedToOpenFallbackURL:
			return "Failed to open the fallback URL."

		case .invalidFallbackURL:
			return "The fallback URL is invalid or malformed."

		case .platformNotSupported:
			return "This platform is not supported for opening URLs."

		case .failedToOpenAppStore:
			return "Could not open the App Store to install the app."
		}
	}
}
