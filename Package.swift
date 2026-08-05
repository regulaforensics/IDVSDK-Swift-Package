// swift-tools-version:5.3
import PackageDescription

let packageName = "IDVSDK"

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v14)
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
            from: "3.9.1898"
        ),
    ],
    targets: [
        .binaryTarget(
            name: packageName,
            url: "https://pods.regulaforensics.com/\(packageName)/3.9.1987/\(packageName)-3.9.1987.zip",
            checksum: "fa2057c0874cacaa182521f855a18491346bafb2d0dd7b4aca135f3d09ca0068"
        ),
        .target(
            name: "\(packageName)Common",
            dependencies: [
                .target(name: packageName),
                .product(name: "IDVModule", package: "IDVModule"),
            ],
            path: "Sources",
            sources: ["dummy.swift"]
        )
    ]
)
