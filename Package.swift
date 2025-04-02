// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "grocery-app-server",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", .upToNextMajor(from: "4.12.0")),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "5.0.0")
    ],
    targets: [
        .executableTarget(
            name: "grocery-app-server",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "JWTKit", package: "jwt-kit"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "grocery-app-serverTests",
            dependencies: [
                .target(name: "grocery-app-server"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
