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
    
    func register(req: Request) async throws -> String {
        
        // validate the user // validation
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        // find if the user already exitst
        
        return "OK"
    }
}
