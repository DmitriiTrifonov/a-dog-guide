//
//  DogResponse.swift
//  a-dog-guide
//
//  Created by Dmitrii Trifonov on 14.12.2019.
//  Copyright © 2019 Dmitrii Trifonov. All rights reserved.
//

import Foundation

struct DogResponse: Codable {
    let message: [String: [String]]
}
