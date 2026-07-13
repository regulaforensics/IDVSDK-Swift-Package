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
            from: "3.8.1846"
        ),
    ],
    targets: [
        .binaryTarget(
            name: packageName,
            url: "https://pods.regulaforensics.com/\(packageName)/3.8.1948/\(packageName)-3.8.1948.zip",
            checksum: "9e9221393967f97e3f2e546ef3d84299ef59a1d8665ec6842805b0a516d3e30f"
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
