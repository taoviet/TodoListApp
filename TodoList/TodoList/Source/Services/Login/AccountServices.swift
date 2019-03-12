//
//  AccountServices.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import Alamofire

class AccountServices {
    
    func signIn(_ param: [String:Any], completion: @escaping (AccountResponse?, BaseError?) -> Void) -> Void {
        AF.request(ApiRouter.login(param)).responseObject { (response : DataResponse<AccountResponse>) in
            completion(response.result.value, ServiceUtil.errorFromResponse(response.result.error, response: response.result.value) )
        }
    }
    
}

