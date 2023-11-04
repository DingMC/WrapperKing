// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WrapperKing",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WrapperKing", //指定库的名称
            //type: .dynamic, // 指定库是静态库还是动态库，默认是静态库
            targets: ["WrapperKing"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WrapperKing"),
        .testTarget(
            name: "WrapperKingTests",
            dependencies: ["WrapperKing"]),
    ]
)
