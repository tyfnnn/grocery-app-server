import Vapor
import Fluent
import FluentPostgresDriver
import JWT
import JWTKit

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let postgresConfig = SQLPostgresConfiguration(
            hostname: "localhost",
            username: "tyfn",
            password: "",
            database: "grocerydb",
            tls: .prefer(try .init(configuration: .clientDefault))
        )

    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)

    // register migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryCategoryTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())
    
    // register the controllers
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    
    await app.jwt.keys.add(hmac: "SECRETKEY", digestAlgorithm: .sha256)

    // register routes
    try routes(app)
}
