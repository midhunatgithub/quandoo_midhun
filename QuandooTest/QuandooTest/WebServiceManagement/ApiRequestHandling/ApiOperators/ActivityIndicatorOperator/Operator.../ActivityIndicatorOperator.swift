//
//  ActivityIndicatorOperator.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import Foundation
precedencegroup ActivityIndicatorOperatorPrecedence {
    associativity: left
}
// MARK: - Acttivity Indicator Operator ...
infix operator ... : ActivityIndicatorOperatorPrecedence // 1
func ... (left: ApiCommonResult, right: String) -> ApiCommonResult {
      ApiOperatorLinker.linker.showActivityIndicator(with: right)
    return left
}
