//
//  ComicResponseModel.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import Foundation

struct ComicResponseModel : Decodable{
    
    var results : [Comic]
    
    enum CodingKeys : String , CodingKey{
        case data
    }
    
    enum DataKeys : String , CodingKey{
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        var innerContainer = try dataContainer.nestedUnkeyedContainer(forKey: .results)
        var tempArray : [Comic] = []
        while !innerContainer.isAtEnd{
            let comic = try innerContainer.decode(Comic.self)
            tempArray.append(comic)
        }
        self.results = tempArray
    }
    
}
