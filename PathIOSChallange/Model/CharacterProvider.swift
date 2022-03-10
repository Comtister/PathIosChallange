//
//  CharacterDataProvider.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 10.03.2022.
//

import Foundation
import RxSwift

class CharacterProvider{
    
    static let shared : CharacterProvider = CharacterProvider()
    private(set) var offset = 0
    private let limit = 30
    
    private init(){
        
    }
    
    func generateRequest() -> CharactersNetworkRequest{
        
        let characterRequest = CharactersNetworkRequest(limit: String(limit), offset: String(offset))
        offset += 30
        return characterRequest
        
    }
    
}
