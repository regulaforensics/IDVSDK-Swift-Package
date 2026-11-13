// swift-tools-version:5.5
import PackageDescription

let packageName = "IDVSDK"
let binaryTargetName = "IDVSDKNightly"

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: packageName,
            targets: ["\(packageName)Common"]
        ),
    ],
    dependencies: [
        .package(
            name: "IDVModule",
            url: "https://github.com/regulaforensics/IDVModule-Swift-Package.git",
            from: "4.0.2132-nightly"
        ),
    ],
    targets: [
        .binaryTarget(
            name: binaryTargetName,
            url: "https://pods.regulaforensics.com/Nightly/IDVSDKNightly/4.0.2186/IDVSDKNightly-4.0.2186.zip",
            checksum: "78b9dd13fcb9c4a75d21231ef3a0ea1f521c0d44e78ab443dcee70e6e3b31981"
        ),
        .target(
            name: "\(packageName)Common",
            dependencies: [
                .target(name: binaryTargetName),
                .product(name: "IDVModule", package: "IDVModule"),
            ],
            path: "Sources",
            sources: ["dummy.swift"]
        )
    ]
)
