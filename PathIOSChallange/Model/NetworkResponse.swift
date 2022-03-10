//
//  NetworkResponse.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation

class NetworkResponse<T : Decodable> : Decodable{
    
    var rawData : Data
    var json : String?{
        //guard let rawData = rawData else {return nil}
        return String(data: rawData, encoding: .utf8)
    }
    var object : T?
    
    init(data : Data){
        rawData = data
        object = try? JSONDecoder().decode(T.self, from: rawData)
    }
    
}
