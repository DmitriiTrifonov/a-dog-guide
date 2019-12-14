//
//  Breed.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 14.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import Foundation
import ResourceNetworking

struct Breed : Codable{
    let name: String
    let subBreed: [SubBreed]
    
    init(name: String){
        self.name = name
        self.subBreed = [SubBreed]()
    }
    
    init(name: String, subBreed: [String]) {
        self.name = name
        self.subBreed = subBreed.map { SubBreed(name: $0) }
    }
    
    static func getBreedList(from dictionary: [String: [String]]) -> [Breed] {
        return dictionary.map { $0.value.count == 0 ? Breed(name: $0.key) : Breed(name: $0.key, subBreed: $0.value)
        }
    }
}

class ResourceFactory {
    func createResource() -> Resource<DogResponse> {
        return Resource(url: URL(string: "https://dog.ceo/api/breeds/list/all")!, headers: nil)
    }
}
