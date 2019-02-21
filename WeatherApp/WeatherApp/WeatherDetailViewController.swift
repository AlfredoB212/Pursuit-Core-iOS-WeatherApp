//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: ViewController {
    @IBOutlet weak var weatherForcastLabel2: UILabel!
    @IBOutlet weak var descriptiveWeatherLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var ghettoBackButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPixaImage()
    }
    
    func getPixaImage() {
        PixabayAPIClient.searchWeather(keyword: location.replacingOccurrences(of: " ", with: "")) { (error, imageData) in
            if let error = error {
                print(error.errorMessage())
            } else if let imageData = imageData {
                let randomNumber = Int.random(in: 0...imageData.count - 1)
                ImageHelper.fetchImage(url: imageData[randomNumber].largeImageURL) { (appError, image) in
                    if let appError = appError {
                        print(appError)
                    }
                    if let image = image {
                        DispatchQueue.main.async {
                            self.cityImageView.image = image
                        }
                    } else {
                        self.cityImageView.image = image
                    }
                }
            }
        }
    }
    func setupUI() {
        if let detailInfo = Weather {
            highTempLabel.text = "High: \(detailInfo.maxTempF)°F"
            lowTempLabel.text = "Low: \(detailInfo.minTempF)°F"
            sunsetLabel.text = "Sunset: \(DateTimeHelper.formatISOToTime(dateString: detailInfo.sunsetISO))"
            sunriseLabel.text = "Sunrise: \(DateTimeHelper.formatISOToTime(dateString: detailInfo.sunriseISO))"
            precipitationLabel.text = "Precipitation in Inches: \(detailInfo.precipIN)"
            weatherForcastLabel2.text = detailInfo.weather
            descriptiveWeatherLabel.text = "Weather Forcast for \(detailLocation) for \(DateTimeHelper.formatISOToDate(dateString: detailInfo.dateTimeISO))"
            
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Saved!", message: "Image Saved To Favorites", preferredStyle: .alert)
        let okay = UIAlertAction.init(title: "Okay", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
        if let image = cityImageView.image{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = dateformatter.string(from: Date())
            let favoriteAt = DateTimeHelper.formattedDate(date: now)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {return print("No ImageData")}
            
            let favoriteImage = FavoritedImage.init(favoritedAt: favoriteAt, imageData: imageData)
            DataPersistanceModel.favoriteImage(image: favoriteImage)
        }
    }
}
    

    

