//
//  DogImage.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 15.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import Foundation
import ResourceNetworking

struct DogImage: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
           case imageUrl = "message"
    }
    
}


extension ResourceFactory {
    func createImageResource() -> Resource<DogImage> {
    return Resource(url: URL(string: "https://dog.ceo/api/breeds/image/random")!, headers: nil)
    }
}
