//
//  Dog.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 16.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import Foundation


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
