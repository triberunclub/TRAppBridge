import Foundation

/// Represents an action that can be performed in an external application.
public protocol ExternalApplicationAction {
	var paths: ActionPaths { get }
}
