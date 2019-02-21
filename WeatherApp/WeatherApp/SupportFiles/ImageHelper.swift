//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
final class ImageHelper {
    static func fetchImage(url: URL, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
            }
            if let data = data{
                let image = UIImage(data: data)
                completionHandler(nil, image)
            }
            }.resume()
    }
}
    

