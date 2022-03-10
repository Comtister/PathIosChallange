//
//  Character.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation

struct MarvelCharacter : Decodable{
    
    let id : Int
    let description : String
    let name : String
    let imageType : String
    let imageUrl : String
    var imageDownloadUrl : URL{
        get{
            var imageUrl = imageUrl
            imageUrl.append(contentsOf: ".\(imageType)")
            var url = URLComponents(string: imageUrl)!
            url.queryItems = [URLQueryItem(name: "ts", value: "1"),URLQueryItem(name: "apikey", value: "26e82826c2a3daba9eb1a2f1ecbed44c"),URLQueryItem(name: "hash", value: "4258125eb1b4ae9d26ee59dc43e805e2")]
            return url.url!
        }
    }
    
    enum CodingKeys : String , CodingKey{
        case thumbnail = "thumbnail" , id = "id" , description = "description" , name = "name"
    }
    
    enum ThumbKeys : String , CodingKey{
        case path = "path" , imageType = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.name = try container.decode(String.self, forKey: .name)
        let thumbContainer = try container.nestedContainer(keyedBy: ThumbKeys.self, forKey: .thumbnail)
        //self.imageUrl = try thumbContainer.decode(String.self, forKey: .path)
        var imageUrl = try thumbContainer.decode(String.self, forKey: .path)
        let index = imageUrl.index(imageUrl.startIndex, offsetBy: 4)
        imageUrl.insert("s", at: index)
        self.imageUrl = imageUrl
        self.imageType = try thumbContainer.decode(String.self, forKey: .imageType)
    }
    
}
