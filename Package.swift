// swift-tools-version:5.9
import PackageDescription

let package = Package(
	name: "TRAppBridge",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "TRAppBridge",
			targets: [
				"TRAppBridge"
			]
		),
	],
	targets: [
		.target(
			name: "TRAppBridge",
			dependencies: [],
			resources: [.process("Resources")],
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
