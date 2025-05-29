//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 02.04.25.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {
    
    typealias Payload = AuthPayload
    
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case userId = "userId"
    }
    
    var expiration: ExpirationClaim
    var userId: UUID
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }
}
