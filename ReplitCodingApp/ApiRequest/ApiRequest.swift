//
//  apiRequest.swift
//  ReplitCodingApp
//
//  Created by user on 11/17/21.
//

import Foundation

struct ApiRequest {
    
    static func uploadCode(_ code: String, completionHandler: @escaping(Result<String, NetwordError>) -> Void) {
        guard let fullURL = URL(string: "https://eval-backend.prisonmike135.repl.co/exec") else {
            completionHandler(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let jsonDictionary: [String: String] = [
            "language": "python",
            "command": code,
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            
            let task = URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
                if let error = error {
                    completionHandler(.failure(.putRequestError(error.localizedDescription)))
                    return
                }
                
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(.httpURLResponseError))
                    return
                }
                
                guard let responseData = data else {
                    completionHandler(.failure(.responseDataError))
                    return
                }
                
                let responseCode = httpURLResponse.statusCode
                
                switch responseCode {
                case 400, 404:
                    let errorBody = String(data: responseData, encoding: .utf8)
                    
                    completionHandler(.failure(.respondeCodeError(errorBody ?? "400 or 404 error")))
                    return
                default:
                    break
                }
                
                guard let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                      let jsonData = responseJSONData as? [String: String],
                      let result = jsonData["result"] else {
                    completionHandler(.failure(.responseDataError))
                    return
                }
                
                completionHandler(.success(result))
            }
            
            task.resume()
            
        } catch {
            completionHandler(.failure(.jsonDictionaryNotValid))
        }
        
        
    }
    
}
