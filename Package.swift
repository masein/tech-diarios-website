// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "TechDiarios",
    products: [
        .executable(
            name: "TechDiarios",
            targets: ["TechDiarios"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "TechDiarios",
            dependencies: ["Publish"]
        )
    ]
)