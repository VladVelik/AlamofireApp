//
//  Picture.swift
//  AlamofireApp
//
//  Created by Sosin Vladislav on 23.01.2023.
//

import Foundation

struct Picture: Codable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
    
    init(pictureData: [String : Any]) {
        id = pictureData["id"] as? String
        author = pictureData["author"] as? String
        width = 0
        height = 0
        url = ""
        download_url = pictureData["download_url"] as? String
    }
    
    static func getPictures(from value: Any) -> [Picture] {
        guard let picturesData = value as? [[String: Any]] else { return [] }
        return picturesData.compactMap { Picture(pictureData: $0) }
    }
}
