//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 01.04.25.
//

import Foundation
import Vapor
import Fluent

class UserController: RouteCollection, @unchecked Sendable {
    
    
    @Sendable func boot(routes: any RoutesBuilder) throws {
        let api = routes.grouped("api")
        // api register
        api.post("register", use: register)
        
        // api/login
        api.post("login", use: login)
    }
    
    func login(req: Request) async throws -> LoginResponseDTO {
        
        // Decode the request
        let user = try req.content.decode(User.self)
        
        // check if the user exists in the database
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            return LoginResponseDTO(error: true, reason: "Username is not found.")
        }
        
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        // implementing
        if !result {
            return LoginResponseDTO(error: true, reason: "Password is incorrect.")
        }
        
        // generate the token and return it to the user
        let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userId: existingUser.requireID())
        
        return try await LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existingUser.requireID())
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO {
        
        // validate the user // validation
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        // find if the user already exitst
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username is already taken.")
        }
        
        // hash the password
        user.password = try await req.password.async.hash(user.password)
        // save the user to database
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
}
