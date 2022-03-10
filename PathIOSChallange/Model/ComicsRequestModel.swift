//
//  ComicsRequestModel.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import Foundation

class ComicsRequestModel : NetworkRequest{
    
    let charID : String
    
    override var baseUrl: String{
        return "https://gateway.marvel.com/"
    }
    
    override var path: String{
        return "v1/public/characters/\(charID)/comics"
    }
    
    override var body: [String : String]?{
        
        return ["ts" : "1","apikey" : "26e82826c2a3daba9eb1a2f1ecbed44c" , "hash" : "4258125eb1b4ae9d26ee59dc43e805e2" , "format" : "comic" , "formatType" : "comic" , "dateRange" : "2005-01-01,2022-03-10" , "limit" : "10"]
    }
    
    init(charID : String){
        self.charID = charID
    }
    
}
