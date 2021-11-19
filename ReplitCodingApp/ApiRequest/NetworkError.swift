//
//  NetworkErro.swift
//  ReplitCodingApp
//
//  Created by user on 11/18/21.
//

import Foundation

enum NetwordError: Error {
    case jsonDictionaryNotValid
    case badURL
    case putRequestError(_ error: String)
    case httpURLResponseError
    case responseDataError
    case respondeCodeError(_ error: String)
}

extension NetwordError: LocalizedError {
    var errorDescription: String? {
            switch self {
            case .jsonDictionaryNotValid:
                return NSLocalizedString(
                    "Error serializing data from json dictionary",
                    comment: ""
                )
            case .badURL:
                return NSLocalizedString(
                    "Request URL not valid",
                    comment: ""
                )
            case .putRequestError(let error):
                return NSLocalizedString(
                    "Error making PUT request: \(error)",
                    comment: ""
                )
            case .httpURLResponseError:
                return NSLocalizedString(
                    "Error declaring type of response as HTTPURLResponse",
                    comment: ""
                )
            case .responseDataError:
                return NSLocalizedString(
                    "Response has no data",
                    comment: ""
                )
            case .respondeCodeError(let error):
                return NSLocalizedString(
                    error,
                    comment: ""
                )
            }
        }
}
