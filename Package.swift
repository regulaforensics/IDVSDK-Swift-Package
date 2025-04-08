// swift-tools-version:5.3
import PackageDescription

let packageName = "IDVSDK"

let package = Package(
    name: "IDVSDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "IDVSDK",
            targets: ["\(packageName)Common"]),
    ],
    dependencies: [
        .package(name: "IDVModule", url: "https://github.com/regulaforensics/IDVModule-Swift-Package.git", .exact(Version(stringLiteral: "0.1.118"))),
        .package(name: "IDVCoreSDK", url: "https://github.com/regulaforensics/IDVCoreSDK-Swift-Package.git", .exact(Version(stringLiteral: "2.3.225"))),
    ],
    targets: [
        .binaryTarget(name: "IDVSDK", url: "https://pods.regulaforensics.com/IDVSDK/2.3.367/IDVSDK-2.3.367.zip", checksum: "5c2986f8472a49017076f3eed63edb994086691ff3c125e84d7861399a48d6f6"),
        .target(
            name: "\(packageName)Common",
            dependencies: [
                .target(name: "IDVSDK"),
                .product(name: "IDVModule", package: "IDVModule"),
                .product(name: "IDVCoreSDK", package: "IDVCoreSDK")
            ],
            path: "Sources",
            sources: ["dummy.swift"]
        )
    ]
)
