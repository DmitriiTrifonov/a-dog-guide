//
//  Breed.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 14.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import Foundation
import ResourceNetworking

struct DogResponse: Codable {
    let message: [String: [String]]
}

struct SubBreed {
    let name: String
}

struct DogImage: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
           case imageUrl = "message"
    }
    
}

struct Breed {
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

struct Dog {
    let fullBreedName: String
    
    var photoGetUrl: String {
        get {
            return "https://dog.ceo/api/breed/\(fullBreedName)/images/random"
        }
    }
    
    var caps: String {
        get {
            return fullBreedName.replacingOccurrences(of: "/", with: " ").capitalized
        }
    }
    
    func getImgUrl(image: @escaping (String) -> (Void)) {
        if let url = URL(string: photoGetUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let dogImage = try! JSONDecoder().decode(DogImage.self, from: data)
                    image(dogImage.imageUrl)
                }
            }.resume()
        }
    }

    static func createDogList(from: [Breed]) -> [Dog] {
        var dogList = [Dog]()
        _ = from.forEach { b in
            if (b.subBreed.count == 0) {
                dogList.append(Dog(fullBreedName: b.name))
            } else {
                b.subBreed.forEach {
                    sub in
                    dogList.append(Dog(fullBreedName: "\(b.name)/\(sub.name)"))
                }
            }
        }
        return dogList
    }
}


class ResourceFactory {
    func createResource() -> Resource<DogResponse> {
        return Resource(url: URL(string: "https://dog.ceo/api/breeds/list/all")!, headers: nil)
    }
    
}

