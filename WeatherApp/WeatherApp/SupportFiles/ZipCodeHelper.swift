//
//  ZipCodeHelper.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//
//  Returns the locality name for a given zip code
//  e.g enter 10023 zip code will return New York
//  See WeatherAppTests

import Foundation
import CoreLocation

class ZipCodeHelper {
  private init() {}
  static func getLocationName(from zipCode: String, completionHandler: @escaping (Error?, String?) -> Void) {
    let geocoder = CLGeocoder()
    DispatchQueue.global(qos: .userInitiated).async {
      geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
        DispatchQueue.main.async {
          if let placemark = placemarks?.first, let name = placemark.locality {
            completionHandler(nil, name)
          } else {
            completionHandler(error, nil)
          }
        }
      }
    }
  }
}
