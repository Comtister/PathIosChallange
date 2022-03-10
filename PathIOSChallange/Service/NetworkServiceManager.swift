//
//  NetworkService.swift
//  PathIOSChallange
//
//  Created by Oguzhan Ozturk on 9.03.2022.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkServiceError : Error{
    case NetworkError , DataNotValid , DataParsingError , ServerError
}

class NetworkServiceManager{
    
    static let shared : NetworkServiceManager = NetworkServiceManager()
    private let session : Session
    
    private init(){
        let sessionConfig = Session.default.sessionConfiguration
        sessionConfig.timeoutIntervalForRequest = 6
        self.session = Session(configuration : sessionConfig)
    }
    
    func sendRequest<T : Decodable>(resultType : T.Type,request : NetworkRequest) -> Single<T>{
            
        return Single.create { [weak self] single in
            let disposable = Disposables.create()
            
            do{
                try self?.session.request(request: request).validate(statusCode: 200...300).response(queue: .global(qos: .userInitiated), completionHandler: { response in
                    switch response.result{
                    case .success(let data) :
                        
                        guard let data = data else { single(.failure(NetworkServiceError.DataNotValid)) ; return }
                        let responseModel = NetworkResponse<T>(data: data)
                        guard let object = responseModel.object else { DispatchQueue.main.async{ single(.failure(NetworkServiceError.DataParsingError)) } ; return }
                        
                        DispatchQueue.main.async { single(.success(object)) }
                        
                    case .failure(let error) :
                        
                        let generalizedError = error.responseCode == nil ? NetworkServiceError.NetworkError : NetworkServiceError.ServerError
                        DispatchQueue.main.async{ single(.failure(generalizedError)) }
                    }
                })
            }catch{
                DispatchQueue.main.async{ single(.failure(NetworkServiceError.NetworkError)) }
            }
            
            return disposable
        }
            
        
            //if !NetworkMonitor.networkMonitor.isConnected {completion(Result.failure(NetworkServiceError.NetworkError)) ; return}
            /*
            do{
                try session.request(request: request).validate(statusCode: 200...300).response(queue: .global(qos: .userInitiated), completionHandler: { response in
                    switch response.result{
                    case .success(let data) :
                        guard let data = data else {completion(Result.failure(NetworkServiceError.DataNotValid)) ; return}
                        
                        let responseModel = NetworkResponse<T>(data: data)
                        print(responseModel.json)
                        guard let object = responseModel.object else {completion(Result.failure(NetworkServiceError.DataParsingError)) ; return}
                        completion(Result.success(object))
                        
                    case .failure(let error) :
                        let generalizedError = error.responseCode == nil ? NetworkServiceError.NetworkError : NetworkServiceError.ServerError
                        completion(Result.failure(error))
                    }
                })
            }catch{
                completion(Result.failure(NetworkServiceError.NetworkError))
            }*/
            
        }
    
}
