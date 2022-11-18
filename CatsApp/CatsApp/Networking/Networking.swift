//
//  Networking.swift
//  CatsApp
//
//  Created by Michael Sweeney on 11/16/22.
//

import Foundation

enum NetworkError: Error {
    case failedDataTransform
}

struct Networking {
    static var dataTask: URLSessionDataTask?
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    struct CatAAS {
        static let baseURL = "https://cataas.com/api/cats"
    
        static func getCats(limit: Int,skip: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
            let route = "\(baseURL)?limit=\(limit)&skip=\(skip)"
            let urlComponents = URLComponents(string: route)
            guard let url = urlComponents?.url else { return }
            let defaultSession = URLSession(configuration: .default)
            dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
                
                if let error = error {
                    completion(Result.failure(error))
                }
                
                else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    let cats = try? Networking.decoder.decode([Cat].self, from: data)
                    dump(cats)
                    if let cats = cats {
                        completion(Result.success(cats))
                    } else {
                        print("failure to decode cats")
                    }
                    
                }
            })
            dataTask?.resume()
        }
    }
    struct CatFacts {
        static let baseURL = "https://catfact.ninja"
        
        static func getFacts(limit: Int, completion: @escaping (Result<[CatFact], Error>) -> Void) {
            let route = "\(baseURL)/facts?limit=\(limit)"
            let urlComponents = URLComponents(string: route)
            guard let url = urlComponents?.url else { return }
            let defaultSession = URLSession(configuration: .default)
            dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
                
                if let error = error {
                    completion(Result.failure(error))
                }
                
                else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    guard let decodedResult = try? Networking.decoder.decode(FactsCollection.self, from: data) else {
                        print("failure to transform to facts collect")
                        let error = NetworkError.failedDataTransform
                        completion(Result.failure(error))
                        return
                    }
                     
                    let allFacts = decodedResult.data
                    completion(Result.success(allFacts))
                }
            })
            dataTask?.resume()
        }
    }
}

extension Networking.CatFacts {
    
}
