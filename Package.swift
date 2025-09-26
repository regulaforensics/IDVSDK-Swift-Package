// swift-tools-version:5.3
import PackageDescription

let packageName = "IDVSDK"

let package = Package(
    name: packageName,
    platforms: [.iOS(.v14)],
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
            from: "3.1.1203"
        ),
        .package(
            name: "IDVCoreSDK",
            url: "https://github.com/regulaforensics/IDVCoreSDK-Swift-Package.git",
            .exact(Version(stringLiteral: "3.1.256"))
        ),
    ],
    targets: [
        .binaryTarget(
            name: packageName,
            url: "https://pods.regulaforensics.com/\(packageName)/3.1.1492/\(packageName)-3.1.1492.zip",
            checksum: "c2c42c41da56e60f3c070112451202bd9a14725b1041e9876b3ea9d355105925"
        ),
        .target(
            name: "\(packageName)Common",
            dependencies: [
                .target(name: packageName),
                .product(name: "IDVModule", package: "IDVModule"),
                .product(name: "IDVCoreSDK", package: "IDVCoreSDK")
            ],
            path: "Sources",
            sources: ["dummy.swift"]
        )
    ]
)
