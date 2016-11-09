//
//  PostRequestOperator.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import Foundation
precedencegroup PostRequestOperatorPrecedence {
    associativity: left
}
// MARK: - POST Request Operator *>.
infix operator *> :PostRequestOperatorPrecedence // 1
func *>(left: NSDictionary, right: String) -> ApiCommonResult {
     ApiOperatorLinker.linker.printForDebug(any: "params = \(left)")
    let result = ApiCommonResult()
    ApiOperatorLinker.linker.apiSessionManager.post(right, parameters: left, progress: { (progress:Progress) in
        result.doProgress(progress: progress)
        }, success: { (operation:URLSessionDataTask, response:Any?) in
            guard let nonEmptyResponse = response else {
                result.doFailure(error: NSError(domain: "web.service.result", code: 1000, userInfo: [:]))
                return
            }
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: nonEmptyResponse, options:[])
                let dataString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
                ApiOperatorLinker.linker.printForDebug(any: "response = \(dataString)")
                result.doSuccess(data: jsonData as NSData)
            } catch let parseError as NSError {
                result.doFailure(error: parseError)
            }
    }) { (operation:URLSessionDataTask?, error:Error) in
        result.doFailure(error: error as NSError)
        
    }
    
    return result
}
