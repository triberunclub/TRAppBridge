// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "TRAppBridge",
	platforms: [
		.iOS(.v13)
	],
	products: [
		.library(
			name: "TRAppBridge",
			targets: [
				"TRAppBridge"
			]
		),
	],
	dependencies: [
		// Add any external dependencies here
	],
	targets: [
		.target(
			name: "TRAppBridge",
			dependencies: [],
			swiftSettings: [
				.define("IMPORT_UIKIT", .when(platforms: [.iOS]))
			]
		),
		.testTarget(
			name: "TRAppBridgeTests",
			dependencies: [
				"TRAppBridge"
			]
		),
	],
	swiftLanguageVersions: [.v5]
)

#if swift(>=5.6)
package.dependencies.append(
	.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
)
#endif
