//
//  Pixabay.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Pixabay: Codable {
    let hits: [LargeImage]
}

struct LargeImage: Codable {
    let largeImageURL: URL
}
