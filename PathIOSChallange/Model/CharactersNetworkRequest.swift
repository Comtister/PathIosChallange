//
//  CharactersNetworkRequest.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation
import CryptoKit

class CharactersNetworkRequest : NetworkRequest{
    
    let limit : String
    let offset : String
    
    override var baseUrl: String{
        return "https://gateway.marvel.com/"
    }
    
    override var path: String{
        return "v1/public/characters"
    }
    
    override var body: [String : String]?{
        
        let ts = Date.init()
        let hashString = String("\(ts.description)3b1062f5e75b186a2f9959dbf2d1c7efbaff4d7026e82826c2a3daba9eb1a2f1ecbed44c")
        let mdT = Insecure.MD5.hash(data: hashString.data(using: .utf8)!)
        print(mdT)
        print(ts.description)
        return ["ts" : "1","apikey" : "26e82826c2a3daba9eb1a2f1ecbed44c" , "hash" : "4258125eb1b4ae9d26ee59dc43e805e2", "limit" : limit , "offset" : offset]
    }
    
    init(limit : String , offset : String){
        self.limit = limit
        self.offset = offset
    }
    
}
