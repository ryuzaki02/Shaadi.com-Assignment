//
//  AddressModel.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import Foundation

struct Geo: Codable {
    var lat: String?
    var lng: String?
}

struct AddressModel: Codable {
    
    var street: String?
    var suite: String?
    var zipcode: String?
    var city: String?
    var geoModel: Geo?
    
    enum CodingKeys: String, CodingKey{
        case street = "street"
        case suite = "suite"
        case zipcode = "zipcode"
        case city = "city"
        case geoModel = "geo"
    }
    
}
