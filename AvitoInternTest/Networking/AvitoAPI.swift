//
//  AvitoAPI.swift
//  AvitoInternTest
//
//  Created by Dilshodi Kahori on 31/10/22.
//

import Foundation

class AvitoAPI {
    
    enum HTTPMethod: String {
        case get = "GET"
        
        var method: String {
            rawValue.uppercased()
        }
    }
    
    enum APIError: Error {
        case invalidResponse
        case invalidData
    }
    
    func requestData<T: Decodable>(fromURL url: URL, httpMethod: HTTPMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionOnMain(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(jsonData))
            } catch {
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
}
