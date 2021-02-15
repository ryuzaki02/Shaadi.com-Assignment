//
//  UserModel.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import Foundation
import UIKit

struct UserModel: Codable {
    var userId: Int?
    var name: String?
    var userName: String?
    var email: String?
    var addressModel: AddressModel?
    var phone: String?
    var website: String?
    var companyModel: CompanyModel?
    var starred = false
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name = "name"
        case userName = "username"
        case email = "email"
        case addressModel = "address"
        case phone = "phone"
        case website = "website"
        case companyModel = "company"
    }
    
    mutating func updateStarred(isFavorite: Bool){
        self.starred = isFavorite
    }
}

extension UserModel: Equatable{
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.userId == rhs.userId
    }
}
