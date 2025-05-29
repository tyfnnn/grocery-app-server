//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 29.05.25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension LoginResponseDTO: @retroactive AsyncResponseEncodable {}
extension LoginResponseDTO: @retroactive AsyncRequestDecodable {}
extension LoginResponseDTO: @retroactive ResponseEncodable {}
extension LoginResponseDTO: @retroactive RequestDecodable {}
extension LoginResponseDTO: @retroactive Content {
    
}

