//
//  RegisterResponseDTO.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 29.05.25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension RegisterResponseDTO: @retroactive AsyncResponseEncodable {}
extension RegisterResponseDTO: @retroactive AsyncRequestDecodable {}
extension RegisterResponseDTO: @retroactive ResponseEncodable {}
extension RegisterResponseDTO: @retroactive RequestDecodable {}
extension RegisterResponseDTO: @retroactive Content {
    
}
