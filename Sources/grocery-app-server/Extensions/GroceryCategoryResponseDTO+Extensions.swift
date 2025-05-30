//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 30.05.25.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryCategoryResponseDTO: @retroactive AsyncResponseEncodable {}
extension GroceryCategoryResponseDTO: @retroactive AsyncRequestDecodable {}
extension GroceryCategoryResponseDTO: @retroactive ResponseEncodable {}
extension GroceryCategoryResponseDTO: @retroactive RequestDecodable {}
extension GroceryCategoryResponseDTO: @retroactive Content {
    init?(_ groceryCategory: GroceryCategory) {
        guard let id = groceryCategory.id else {
            return nil
        }
        self.init(id: id, title: groceryCategory.title, colorCode: groceryCategory.colorCode)
    }
}
