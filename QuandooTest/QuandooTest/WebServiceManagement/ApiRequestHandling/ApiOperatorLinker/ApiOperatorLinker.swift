//
//  ApiOperatorLinker.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit
import AFNetworking
// creating a session manager (AFHTTPSessionManager)
class ApiOperatorLinker {
    static let linker =  ApiOperatorLinker()
    var apiSessionManager =  AFHTTPSessionManager(baseURL: ApiConstants.baseUrl as URL?)
    private init(){
        
    }
    //MARK: - Activity Indicatior methods.
    func showActivityIndicator(with text:String){
        dispatchOnMainQueue {
            ActivityIndicatorView.showFoodieActivity(title: text)
        }
    }
    func hideActivityIndicator(){
        dispatchOnMainQueue {
            ActivityIndicatorView.hideFoodieActivity()
        }
    }
    //MARK: - Response log methods.
    func printForDebug(any:Any)  {
        #if DEBUG
            print(any)
        #endif
    }
}
