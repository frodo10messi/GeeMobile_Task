//
//  UserRemoteLoader.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

import Foundation
final class UserRemoteLoader: UserLoader {
  
    typealias Result = UserLoader.Result
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
 
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(UserMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

