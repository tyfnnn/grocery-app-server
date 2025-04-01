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
