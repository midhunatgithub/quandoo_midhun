//
//  ApiRequestManager.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
import JSONJoy
class ApiRequestManager: NSObject {
    static let apiRequest = ApiRequestManager()
    private override init() {
    }
    
    // MARK: - webservice call for userList .
    
    func fetchUsers(complitionClosure:@escaping (_ isSucess:Bool, _ users:[UserModel]) -> Void) {
        // operator '<*' is used call a get method. result = params <* service_name
        // operator '...' is used to showing activity indicator during the service call.
        var users = [UserModel]()
        let result = (["":""] <* "users") ... "Fetching..."
        result.onSuccess { (response) in
            do {
                let userList =  try UserList(JSONDecoder(response))
                users = userList.users
                complitionClosure(true, users)
            } catch JSONError.wrongType {
                complitionClosure(false, users)
                showAlert(titel: "Error!", messege: "Unexpected content during the parsing.")
            }catch {
                complitionClosure(false, users)
                showAlert(titel: "Error!", messege: "Unexpected error during the parsing.")
            }
            }.onFailure { (error) in
                complitionClosure(false, users)
                showAlert(titel: "Error!", messege: error.localizedDescription)
        }
    }
    
    // MARK: - webservice call for postList.
    
    func fetchUserPostsWithUserId(userId:String,complitionClosure:@escaping (_ isSucess:Bool, _ postes:[UserPostModel]) -> Void) {
        // operator '<*' is used call a get method. result = params <* service_name
        // operator '...' is used to showing activity indicator during the service call.
        var postes = [UserPostModel]()
        let result = (["userId":userId] <* "posts") ... "Fetching..."
        result.onSuccess { (response) in
            do {
                let postList =  try UserPostList(JSONDecoder(response))
                postes = postList.posts
                complitionClosure(true, postes)
            } catch JSONError.wrongType {
                showAlert(titel: "Error!", messege: "Unexpected content during the parsing.")
                complitionClosure(true, postes)
            }catch {
                showAlert(titel: "Error!", messege: "Unexpected error during the parsing.")
                complitionClosure(true, postes)
            }
            }.onFailure { (error) in
                showAlert(titel: "Error!", messege: error.localizedDescription)
                complitionClosure(true, postes)
        }
       
    }
}
