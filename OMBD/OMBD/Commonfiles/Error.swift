//
//  Error.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import Foundation

enum GithubDemoError: Error {
    
    enum NetworkFailureReason {
        case timeout
        case internetUnavailable
        case networkConnectionLost
        case badRequest
        case emptyResponse
        case general(description: String)
    }
    
    case networkFailed(reason: NetworkFailureReason)
    
    case general(reason: String)
    
}

extension GithubDemoError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .networkFailed(reason):
            return reason.localizedDescription
        case let .general(reason):
            return reason
        }
    }
    
    var localizedDescription: String {
        return errorDescription ?? ""
    }
}

//MARK: - NetworkFailureReson -
extension GithubDemoError.NetworkFailureReason {
    
    var localizedDescription: String {
        switch self {
        case .timeout:
            return "URL request timed out"
        case .internetUnavailable:
            return "Internet is unavaialable"
        case .networkConnectionLost:
            return "The network connection was lost"
        case .badRequest:
        return "Unacceptable status code and wrong request from client"
        case let .general(description):
            return description
        case .emptyResponse:
            return "Received empty response from server"
        }
    }
    
    static var defaultReason: Error {
        return GithubDemoError.networkFailed(reason: GithubDemoError.NetworkFailureReason.general(description: "Something went wrong"))
    }
}

//MARK: - Error -
extension GithubDemoError {
    
    var asMomentError: GithubDemoError? {
        self as? GithubDemoError
    }
    
    func asMomentError(orFailWith message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> GithubDemoError {
        guard let afError = self as? GithubDemoError else {
            fatalError(message(), file: file, line: line)
        }
        return afError
    }
    
    func asMomentError(or defaultMomentError: @autoclosure () -> GithubDemoError) -> GithubDemoError {
        self as? GithubDemoError ?? defaultMomentError()
    }
}
