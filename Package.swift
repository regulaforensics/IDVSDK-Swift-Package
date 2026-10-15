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
            from: "3.10.2045-rc"
        ),
    ],
    targets: [
        .binaryTarget(
            name: binaryTargetName,
            url: "https://pods.regulaforensics.com/Stage/IDVSDKStage/3.10.2125/IDVSDKStage-3.10.2125.zip",
            checksum: "f7a9b494262a6e0380ddfc06a269a28af9b5319aead17ec01a18aae2188daf60"
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
