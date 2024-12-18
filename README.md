# TRAppBridge 🌉

###### Streamlined deep linking for iOS applications

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.5+-orange.svg" alt="Swift">
  <img src="https://img.shields.io/badge/Platforms-iOS-lightgrey.svg" alt="Platforms">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
</p>

## Highlights

+ __Smart Fallback:__
If the target app isn't installed, TRAppBridge falls back to a web URL, ensuring a seamless user experience.

+ __Type-Safe API:__
Leverage Swift's type system for safer, more intuitive deep linking.

+ __Modular Design:__
Easily extend TRAppBridge to support new apps and actions.

## Features

```swift
let bridge = TRAppBridge.shared

// Open Facebook app
bridge.open(.facebook) { result in
    switch result {
    case .success:
        print("Facebook app opened successfully")
    case .failure(let error):
        print("Failed to open Facebook app: \(error)")
    }
}

// Open a specific Facebook profile
bridge.open(.facebook(.profile("username"))) { result in
    // Handle result
}
```

## Supported Apps (growing list)

App | Actions
----|--------
Facebook | Open, Profile, Post
Twitter | Open, Tweet, Profile
Instagram | Open, Camera, Profile
... | ...

## Installation

### Swift Package Manager

Add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/TribeRunClub/TRAppBridge.git", from: "1.0.0")
]
```

## Example Project

An example project demonstrating the usage of TRAppBridge is included in the Example folder. To run the example project:

1. Open Example/TRAppBridgeExample.xcworkspace in Xcode.
2. Build and run the TRAppBridgeExample scheme.

For more details, see the Example Project README.

## Motivation

Deep linking between apps can be challenging and error-prone. TRAppBridge aims to simplify this process, providing a type-safe, easy-to-use API for iOS developers. By centralizing deep linking logic and providing a consistent interface, TRAppBridge reduces the potential for errors and improves code maintainability.

## Contributors

This project is maintained by the Tribe Run Club team. We welcome contributions from the community!

## License

TRAppBridge is released under the MIT license. See [LICENSE](link-to-license) for details.
