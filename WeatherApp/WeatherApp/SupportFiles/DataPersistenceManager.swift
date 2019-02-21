//
//  DataPersistenceManager.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct DataPersistanceManager {
    
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
