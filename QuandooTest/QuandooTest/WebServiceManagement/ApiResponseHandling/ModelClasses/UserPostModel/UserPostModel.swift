//
//  UserPostModel.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/8/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import Foundation
import JSONJoy
// MARK: Final Model
struct UserPostList : JSONJoy {
    var posts = [UserPostModel]()
    init(_ decoder: JSONDecoder) throws {
        if let postArray =  decoder.array {
            var postsTemp = [UserPostModel]()
            for userDecoder in postArray {
                postsTemp.append(try UserPostModel(userDecoder))
            }
            posts = postsTemp
        }
    }
}
// MARK: Main Model
struct UserPostModel : JSONJoy {
    let id:Int
    let userId:Int
    let title:String
    let body:String
        
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].getInt()
        userId = try decoder ["userId"].getInt()
        title = try decoder ["title"].getString()
        body = try decoder["body"].getString()
    }
}
