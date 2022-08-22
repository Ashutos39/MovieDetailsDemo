//
//  APICoordinatorProtocol.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

protocol APICoordinatorProtocol {
    init(withNetworkManager network: NetworkManagerProtocol)
    func requestToCallAPIWithDecodableResponse<T>(with router: GenericNetworkRouter, cancelLast:Bool, _ completion: @escaping (_ result: Result<T, GithubDemoError>) -> Void) where T: Decodable
    func requestToCallAPI(with router: GenericNetworkRouter, cancelLast:Bool, _ completion: @escaping CompletionResponse)
}

extension APICoordinatorProtocol {
    
    func requestToCallAPIWithDecodableResponse<T>(with router: GenericNetworkRouter, cancelLast:Bool = false, _ completion: @escaping (_ result: Result<T, GithubDemoError>) -> Void) where T: Decodable {
        requestToCallAPIWithDecodableResponse(with: router, cancelLast: cancelLast, completion)
    }
    
    func requestToCallAPI(with router: GenericNetworkRouter, cancelLast:Bool = false, _ completion: @escaping CompletionResponse) {
        requestToCallAPI(with: router, cancelLast: cancelLast, completion)
    }
}
