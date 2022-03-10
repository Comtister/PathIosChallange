//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import XCTest
@testable import PathIOSChallange

class NetworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterGet() throws {
        
        let sut = NetworkServiceManager.shared
        let promise = expectation(description: "Data fetch complete")
        let testRequest = CharactersNetworkRequest()
                
        sut.sendRequest(request: testRequest) { (result : Result<CharactersResponse , Error>) in
            switch result {
                case .success(let success):
                        promise.fulfill()
                case .failure(let failure):
                        XCTFail(failure.localizedDescription)
                    }
                }
                wait(for: [promise], timeout: 10)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
