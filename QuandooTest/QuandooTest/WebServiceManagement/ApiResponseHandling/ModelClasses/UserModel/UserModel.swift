//
//  UserModel.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import Foundation
import JSONJoy
// MARK: Final Model
struct UserList : JSONJoy {
    var users = [UserModel]()
    init(_ decoder: JSONDecoder) throws {
        if let userArray =  decoder.array {
            var usersTemp = [UserModel]()
            for userDecoder in userArray {
                usersTemp.append(try UserModel(userDecoder))
            }
            users = usersTemp
        }
    }
}

// MARK: Main Model
struct UserModel : JSONJoy {
    let id:Int
    let name:String
    let username:String
    let email:String
    let phone:String
    let website:String
    let address:AddressModel
    let company:CompanyModel
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].getInt()
        name = try decoder ["name"].getString()
        username = try decoder ["username"].getString()
        email = try decoder["email"].getString()
        phone = try decoder["phone"].getString()
        website = try decoder ["website"].getString()
        address = try AddressModel(decoder["address"])
        company = try CompanyModel(decoder["company"])
    }
}
// MARK: Sub Models
struct CompanyModel : JSONJoy {
    let name:String
    let catchPhrase:String
    let bs:String
    
    init(_ decoder: JSONDecoder) throws {
        name = try decoder["name"].getString()
        catchPhrase = try decoder ["catchPhrase"].getString()
        bs = try decoder ["bs"].getString()
    }
}

struct AddressModel : JSONJoy {
    let street:String
    let suite:String
    let city:String
    let zipcode:String
    let geoLocation:GeoModel
    
    init(_ decoder: JSONDecoder) throws {
        street = try decoder["street"].getString()
        suite = try decoder ["suite"].getString()
        city = try decoder ["city"].getString()
        zipcode = try decoder["zipcode"].getString()
        geoLocation = try GeoModel(decoder["geo"])
    }
}
struct GeoModel : JSONJoy{
    let latitude:String
    let longitude:String
    
    init(_ decoder: JSONDecoder) throws {
        latitude = try decoder["lat"].getString()
        longitude = try decoder ["lng"].getString()
    }
}

