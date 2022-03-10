//
//  Alamofire+NetworkRequest.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation
import Alamofire

extension Session{
    
    func request(request : NetworkRequest) throws -> DataRequest{
            return self.request(request.getRequestUrl()!, method: request.httpMethod, parameters: request.body, encoder: request.encoder, headers: request.httpHeaders, interceptor: nil, requestModifier: nil)
        }
    
}
