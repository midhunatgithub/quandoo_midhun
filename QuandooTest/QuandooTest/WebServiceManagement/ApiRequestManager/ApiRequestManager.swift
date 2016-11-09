//
//  ApiRequestManager.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit

class ApiRequestManager: NSObject {
    static let apiRequest = ApiRequestManager()
    private override init() {
    }
    
    func fetchUsers() -> ApiCommonResult {
         let result = (["":""] <* "users") ... "Fetching..."
         return result
    }
    
    func fetchUserPostsWithUserId(userId:String) -> ApiCommonResult {
          let result = (["userId":userId] <* "posts") ... "Fetching..."
          return result
    }
}
