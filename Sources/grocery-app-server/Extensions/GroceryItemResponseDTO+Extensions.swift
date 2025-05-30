//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 30.05.25.
//

import Foundation
import Vapor
import GroceryAppSharedDTO

extension GroceryItemResponseDTO: @retroactive AsyncResponseEncodable {}
extension GroceryItemResponseDTO: @retroactive AsyncRequestDecodable {}
extension GroceryItemResponseDTO: @retroactive ResponseEncodable {}
extension GroceryItemResponseDTO: @retroactive RequestDecodable {}
extension GroceryItemResponseDTO: @retroactive Content {
    init?(_ groceryItem: GroceryItem) {
        
        guard let groceryItemId = groceryItem.id else {
            return nil
        }
        self.init(id: groceryItemId, title: groceryItem.title, price: groceryItem.price, quantity: groceryItem.quantity)
    }
}
