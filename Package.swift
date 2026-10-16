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
            from: "3.10.2049-nightly"
        ),
    ],
    targets: [
        .binaryTarget(
            name: binaryTargetName,
            url: "https://pods.regulaforensics.com/Nightly/IDVSDKNightly/3.10.2128/IDVSDKNightly-3.10.2128.zip",
            checksum: "a043f38dcb8511ccd2bd2a84838e9881cd010f78e6a1b4d43ff6dac0bbad16da"
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
