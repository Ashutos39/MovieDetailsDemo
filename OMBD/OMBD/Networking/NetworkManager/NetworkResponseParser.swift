//
//  NetworkResponseParser.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation


struct NetworkResponseParser: HelperProtocol {
        
    func parseDecodableResponse<T:Decodable>(_ response: AlamofireDecodableDataResponse<T, AlamofireError>, _ completion: @escaping CompletionDecodableResponse<T>) {
        
        switch response.result {
        case .success(let result):
            debugPrint("result of API with url", response.urlString, "response", response.printableString)
            completion(.success(result))
            
        case .failure(let error):
            debugPrint("error of API with url", response.urlString, "error", error, "response", response.printableString)
            let error = parseFailureResponse(withResponseData: response.data, afError: error)
            completion(.failure(error))
        }
    }
    
    func parseResponse(_ dataResponse: AlamofireDataResponse, _ completion: @escaping CompletionResponse) {
        
        debugPrint("result of API with url", dataResponse.urlString, "result", dataResponse.printableString)
        guard let response = dataResponse.response else {
            completion(dataResponse.data, GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.emptyResponse))
            return
        }
        switch response.statusCode {
        case 200...299:
            completion(dataResponse.data, nil)
        default:
            let Error = parseFailureResponse(withResponseData: dataResponse.data, afError: dataResponse.error)
            completion(dataResponse.data, Error)
        }
    }
}

//MARK: - Private -
private extension NetworkResponseParser {
    
    func parseFailureResponse(withResponseData responseData: Data?, afError error: AlamofireError?) -> GithubDemoError {
        
        let dictResponse: GenericDictionary? = try? responseData?.convertToDictionary()
        let Error = parseResponseError(with: error, errorCode:  dictResponse?.parseAPIFailureErrorCode())
        return Error
    }
    
    func parseResponseError(with afError: AlamofireError?, errorCode: Int? = nil) -> GithubDemoError {
                
        //check AFError exists
        guard let error = afError else {
            return GithubDemoError.NetworkFailureReason.defaultReason as! GithubDemoError
        }
        switch error {
        case .sessionTaskFailed(let error as URLError) where error.code == .timedOut:
            debugPrint("Error !! Timeout error with responseCode \(String(describing: error))")
            return GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.timeout)
            
        case .sessionTaskFailed(let error as URLError) where error.code == .notConnectedToInternet:
            debugPrint("Error !! Not connected to Internet Error\(error)")
            return GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.internetUnavailable)
            
        case .sessionTaskFailed(let error as URLError) where error.code == .networkConnectionLost:
            debugPrint("Error !! Network connection lost\(error)")
            return GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.networkConnectionLost)
        default:
            debugPrint("Other unhandled errors: \(error)")
            return GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.general(description: error.errorDescription ?? "Something went wrong!"))
        }
    }
}

//MARK: - AlamofireDecodableDataResponse -
private extension AlamofireDecodableDataResponse {
    var urlString: String {
        String(any: request?.url?.absoluteString)
    }
    
    var printableString: NSString {
        NSString(string: String(any: data?.stringValue()))
    }
}

