// swift-tools-version:5.5
import PackageDescription

let packageName = "IDVSDK"
let binaryTargetName = "IDVSDKStage"

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
            from: "4.0.2140-rc"
        ),
    ],
    targets: [
        .binaryTarget(
            name: binaryTargetName,
            url: "https://pods.regulaforensics.com/Stage/IDVSDKStage/4.0.2194/IDVSDKStage-4.0.2194.zip",
            checksum: "871b7daf2657ccdbd0011d89fe8cd78b0fdd2129c9821757f7e9f261d76dad16"
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
