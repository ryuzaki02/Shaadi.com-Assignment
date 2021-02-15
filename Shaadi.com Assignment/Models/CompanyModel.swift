//
//  CompanyModel.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import Foundation

struct CompanyModel: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
}
