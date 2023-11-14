// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Package.swift
// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "DessertFinder",
    platforms: [
        .iOS(.v13), // Adjust the platform version as needed
    ],
    products: [
        .library(
            name: "DessertFinder",
            targets: ["DessertFinder"]
        ),
    ],
    targets: [
        .target(
            name: "DessertFinder",
            dependencies: [],
            path: "DessertFinderApp" // Update the path to your actual source files location
        ),
        .testTarget(
            name: "DessertFinder",
            dependencies: ["DessertFinder"]
        ),
    ]
)
