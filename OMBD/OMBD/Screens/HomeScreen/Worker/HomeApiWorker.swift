//
//  HomeApiWorker.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

final class HomeApiWorker: APIWorkerProtocol {
    
    private let apiCoordinator: APICoordinatorProtocol
    
    init(withNetworkManager manager: NetworkManagerProtocol) {
        apiCoordinator = APICoordinator(withNetworkManager: manager)
    }
    
    var url: String {
        DemoStringConstant.baseUrl
    }
    
    func getData(perPage: Int, _ completionHandler: @escaping (_ result: Result<HomeModel, GithubDemoError>) -> Void) {
        let finalUrl = url + "\(perPage)"
        let router = GenericNetworkRouter(encodingType: .jsonEncoding, method: .get, bodyParameters: nil, url: finalUrl, headers: nil, urlParameters: nil, retryCount: 0)
        apiCoordinator.requestToCallAPIWithDecodableResponse(with: router, completionHandler)
    }
    
}
