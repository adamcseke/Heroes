//
//  APICaller.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let url = "https://www.mocky.io/v2/5addd58b30000066154b28c9"
        static let apiKey = ""
    }
    
    private init() {}

    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        var authUrl = url
        authUrl.appendQueryParameters([:])
        let task = URLSession.shared.dataTask(with: authUrl) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
            else if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let exepction {
                    DispatchQueue.main.async {
                        completion(.failure(exepction))
//                        print(exepction.localizedDescription)
                        print(String(describing: exepction))
                    }
                }
            }
        }
        task.resume()
    }
}
