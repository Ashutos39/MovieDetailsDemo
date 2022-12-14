//
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

// MARK:- A genric APIRouter to build URLRequests
struct GenericNetworkRouter: NetworkRouterProtocol {

    var encodingType: ParameterEncoding
    var method: DemoHTTPMethod
    var bodyParameters: Parameters? = nil
    var url: String
    var headers: HTTPHeader?
    var urlParameters: Parameters? = nil
    var retryCount: Int?
}
