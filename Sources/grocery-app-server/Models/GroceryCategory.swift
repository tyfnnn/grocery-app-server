//
//  File.swift
//  grocery-app-server
//
//  Created by Tayfun Ilker on 30.05.25.
//

import Foundation
import Vapor
import Fluent

final class GroceryCategory: Model, Content, Validatable, @unchecked Sendable {
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "Title cannot be empty.")
        validations.add("colorCode", as: String.self, is: !.empty, customFailureDescription: "Color cannot be empty.")
    }
    
    static let schema = "grocery_categories"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "color_code")
    var colorCode: String
    
    @Parent(key: "user_id")
    var user: User
    
    init() { }
    
    init(id: UUID? = nil, title: String, colorCode: String, userId: UUID) {
        self.id = id
        self.title = title
        self.colorCode = colorCode
        self.$user.id = userId
    }
}
