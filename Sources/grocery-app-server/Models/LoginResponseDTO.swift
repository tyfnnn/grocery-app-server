//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 02.04.25.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
    let token: String?
    let userId: UUID?
}
