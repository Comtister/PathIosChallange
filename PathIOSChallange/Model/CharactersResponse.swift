//
//  CharactersResponse.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation

struct CharactersResponse : Decodable{
    
    let offset : Int
    let results : [MarvelCharacter]
    
    enum CodingKeys : String , CodingKey{
        case data = "data"
    }
    
    enum DataKeys : String , CodingKey{
        case offset = "offset" , results = "results"
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
            self.offset = try dataContainer.decode(Int.self, forKey: .offset)
            var innerContainer = try dataContainer.nestedUnkeyedContainer(forKey: .results)
            var tempArray : [MarvelCharacter] = []
            while !innerContainer.isAtEnd{
                let character = try innerContainer.decode(MarvelCharacter.self)
                tempArray.append(character)
            }
            results = tempArray
        }
    
    
    
}
