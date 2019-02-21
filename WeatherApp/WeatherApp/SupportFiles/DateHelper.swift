//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/23/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct DateTimeHelper {
        static func formatISOToDate(dateString: String) -> String {
            let isoDateFormatter = ISO8601DateFormatter()
            var formattedDate = dateString
            if let date = isoDateFormatter.date(from: dateString) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                formattedDate = dateFormatter.string(from: date)
            }
            return formattedDate
            
        }
        static func formatISOToTime(dateString: String) -> String {
            let isoDateFormatter = ISO8601DateFormatter()
            var formattedDate = dateString
            if let date = isoDateFormatter.date(from: dateString) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                formattedDate = dateFormatter.string(from: date)
            }
            return formattedDate
        }
        
        static func formattedDate(date:String) -> String {
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withInternetDateTime, .withDashSeparatorInDate]
            var formattedDate = date
            if let date = isoDateFormatter.date(from: date) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                formattedDate = dateFormatter.string(from: date)
            }
            return formattedDate
        }
        static func formattedTime(time: String) -> String {
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone, .withInternetDateTime, .withDashSeparatorInDate]
            var formattedTime = time
            if let date = isoDateFormatter.date(from: time) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                formattedTime = dateFormatter.string(from: date)
            }
            return formattedTime
        }
    }
    

