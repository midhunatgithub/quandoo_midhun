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
    
    // MARK: - webservice call for userList .
    func fetchUsers() -> ApiCommonResult {
        // operator '<*' is used call a get method. result = params <* service_name
        // operator '...' is used to showing activity indicator during the service call.
        let result = (["":""] <* "users") ... "Fetching..."
        return result
    }
    // MARK: - webservice call for postList .
    func fetchUserPostsWithUserId(userId:String) -> ApiCommonResult {
        // operator '<*' is used call a get method. result = params <* service_name
        // operator '...' is used to showing activity indicator during the service call.
        let result = (["userId":userId] <* "posts") ... "Fetching..."
        return result
    }
}
