// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DessertFinder",
    platforms: [
        .macOS(.v12), // Set macOS version to 12 or any version supported by the Swift version

    ],
    products: [
        .executable(name: "DessertFinder", targets: ["DessertFinder"]),
    ],
    dependencies: [
        // Dependencies go here
    ],
    targets: [
        .executableTarget(
            name: "DessertFinder",
            dependencies: [],
            sources: [
                "DessertFinderApp.swift",
                // Add other Swift files if needed
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
