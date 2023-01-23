//
//  NetworkManager.swift
//  AlamofireApp
//
//  Created by Sosin Vladislav on 23.01.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImagesInfo(url: String, completion: @escaping(Result<[Picture], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let pictures = Picture.getPictures(from: value)
                    completion(.success(pictures))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
