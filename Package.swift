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
        .package(name: "IDVModule", url: "https://github.com/regulaforensics/IDVModule-Swift-Package.git", .exact(Version(stringLiteral: "2.5.539"))),
        .package(name: "IDVCoreSDK", url: "https://github.com/regulaforensics/IDVCoreSDK-Swift-Package.git", .exact(Version(stringLiteral: "2.5.239"))),
    ],
    targets: [
        .binaryTarget(name: "IDVSDK", url: "https://pods.regulaforensics.com/IDVSDK/2.5.800/IDVSDK-2.5.800.zip", checksum: "b46defd37d6eced3526ad76f6bfd34cdd811ffe5dc0774af4a0b2414c6cc9dbe"),
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
