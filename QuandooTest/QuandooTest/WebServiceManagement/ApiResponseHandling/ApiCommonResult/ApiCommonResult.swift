//
//  ApiCommonResult.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import UIKit

class ApiCommonResult: NSObject {
    
    typealias OnProgressClosure = (_ progress: Progress) -> Void
    typealias OnSuccessClosure = (_ data:NSData) -> Void
    typealias OnFailureClosure = (_ error:NSError) -> Void
    
    private var onProgressClosure:OnProgressClosure?
    private var onSuccessClosure:OnSuccessClosure?
    private var onFailureClosure:OnFailureClosure?
    
    @discardableResult func onProgress(completion:@escaping (_ progress: Progress) -> Void) -> ApiCommonResult{
        self.onProgressClosure = completion
        return self
    }
    @discardableResult func onSuccess(completion:@escaping (_ data:NSData) -> Void) -> ApiCommonResult{
        self.onSuccessClosure = completion
        return self
    }
    @discardableResult func onFailure(completion: @escaping  (_ error:NSError) -> Void) -> ApiCommonResult{
        self.onFailureClosure = completion
        return self
    }
    func doProgress(progress: Progress) -> Void{
        guard let clouser = self.onProgressClosure else{
            return
        }
        clouser(progress)
    }
    func doSuccess(data:NSData) -> Void{
        ApiOperatorLinker.linker.hideActivityIndicator()
        guard let clouser = self.onSuccessClosure else{
            return
        }
       
        clouser(data)
    }
    func doFailure(error:NSError) -> Void{
        ApiOperatorLinker.linker.hideActivityIndicator()
        guard let clouser = self.onFailureClosure else{
            return
        }
        
        clouser(error)
    }
}
