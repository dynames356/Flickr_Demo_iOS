//
//  ImageModel.swift
//  Flickr Demo
//
//  Created by Jovial on 07/08/2021.
//

import Foundation

// ImageModel class for Image Retrieval from Flickr API
struct ImageModel: Codable {
    // Small Image URL
    let SmallImageURL: String
    // Big Image URL
    let BigImageURL: String
    // Image Title / Description
    let ImageDesc: String
    
    init() {
        SmallImageURL = ""
        BigImageURL = ""
        ImageDesc = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case SmallImageURL = "url_sq"
        case BigImageURL = "url_m"
        case ImageDesc = "title"
    }
}
