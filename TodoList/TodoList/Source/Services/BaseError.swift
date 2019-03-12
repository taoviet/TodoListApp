//
//  BaseError.swift
//  TodoList
//
//  Created by Huy on 3/10/19.
//  Copyright © 2019 Long. All rights reserved.
//

import Foundation

class BaseError {
    var code: Int!
    var errorMessage: String!
    
    
    init(code errCode:Int, message:String) {
        code = errCode
        errorMessage = message
    }
    
    init(error: NSError) {
        code = error.code
        errorMessage = error.localizedDescription
    }
}

class ServiceUtil: NSObject {
    
    class func errorFromResponse(_ orginError:Error?, response: BaseResponse?) -> BaseError? {
        if orginError == nil  {
            if response != nil {
                let value:BaseResponse = response!
                    var msg = response?.messageError
                    if value.messageError != nil {
                        msg = (value.messageError)!
                    }else {
                        return nil
                }
                    return BaseError(code: 200, message: msg!)
            }
            return nil
        }
        return BaseError(code: (orginError?._code)!, message: (orginError?.localizedDescription)!)
    }
}
