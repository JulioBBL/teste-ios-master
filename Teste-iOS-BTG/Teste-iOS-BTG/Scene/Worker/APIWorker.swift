//
//  APIWorker.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

enum responseType<T> {
    case result(_ value: T)
    case error(description: String?)
}

public class APIWorker {
    let endpoint = "https://www.btgpactualdigital.com/services/public/funds/"
    
    private func makeRequest<T: Decodable>(toURL url: String, expecting t: T.Type, completion: @escaping (responseType<T>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.error(description: "provided invalid URL"))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completion(.error(description: error?.localizedDescription))
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                completion(.error(description: "received empty response."))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(t, from: responseData)
                completion(.result(data))
            } catch let error {
                completion(.error(description: "Couldn't deserialize JSON. \(error.localizedDescription)"))
            }
        })
        
        task.resume()
    }
    
    func getFunds(_ block: @escaping ([CodableFund]) -> Void) {
        self.makeRequest(toURL: self.endpoint, expecting: [CodableFund].self) { [weak self](response) in
            switch response {
            case .result(let funds):
                block(funds)
            case .error(let description):
                fatalError("API error: \(String(describing: description))")
            }
        }
    }
}
