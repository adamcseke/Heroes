//
//  APICaller+Heroes.swift
//  Heroes
//
//  Created by Adam Cseke on 2022. 02. 02..
//

import Foundation

extension APICaller {
    
    public func getHeroes(param: String, completion: @escaping (Result<Heroes, Error>) -> Void) {
        let url = Constants.url + "\(param)"
        request(urlString: url, completion: completion)
    }
}
