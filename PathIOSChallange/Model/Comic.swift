//
//  Comic.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import Foundation

struct Comic : Decodable{
    
    let title : String
    let date : Int
    
    enum CodingKeys : String , CodingKey{
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        let capStart = title.firstIndex(of: "(")!
        let capIndex = title.index(capStart, offsetBy: 1)
        let capEnd = title.firstIndex(of: ")")!
        let capEndIndex = title.index(capEnd, offsetBy: -1)
        let tt = title[capIndex...capEndIndex]
        print(tt)
        self.date = Int(tt)!
        
    }
    
}
