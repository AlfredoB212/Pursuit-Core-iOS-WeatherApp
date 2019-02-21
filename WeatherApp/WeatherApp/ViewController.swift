//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var zipCodeTextFIeld: UITextField!
    
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    var keyword = "10002"
    var location = String()
    
    var forcast = [ForcastData]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let zipcode = UserDefaults.standard.object(forKey: "ZipCodes") as? String{
            keyword = zipcode
        }
        ZipCodeHelper.getLocationName(from: keyword) { (error, data) in
            if let error = error {
                print(error)
            } else if let data = data {
                self.location = data
                self.zipCodeTextFIeld.text = "Weather Forcast for \(self.location)"
            }
        }
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        zipCodeTextFIeld.delegate = self
        getWeather(keyword: keyword)
    }
    
    
    func getWeather(keyword: String) {
        WeatherAndImageAPIClient.WeatherAPIClient.searchWeather(keyword: keyword, isZipcode: true) { (error, data) in
            if let error = error {
                print(error.errorMessage())
            } else if let data = data {
                self.forcast = data
            }
        }
    }
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        let cellToSet = forcast[indexPath.row]
        cell.highTempLabel.text = "High: \(cellToSet.maxTempF)°F"
        cell.lowTempLabel.text = "Low: \(cellToSet.minTempF)°F"
        cell.forcastImage.image = UIImage(named: cellToSet.icon)
        cell.dateLabel.text = DateTimeHelper.formatISOToDate(dateString: cellToSet.dateTimeISO)
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 165, height: 265)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "ForcastDVC") as? WeatherDetailViewController else {
            return
        }
        let dayWeather = forcast[indexPath.row]
        detailVC.detailForcast = dayWeather
        detailVC.cityWeather = location
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            ZipCodeHelper.getLocationName(from: keyword) { (error, data) in
                if let error = error {
                    print(error)
                } else if let data = data {
                    UserDefaults.standard.set(keyword, forKey: "ZipCode")
                    self.location = data
                    self.cityWeather.text = "Weather Forcast for \(self.location)"
                }
            }
            UserDefaults.standard.set(keyword, forKey: "ZipCode")
            self.getWeather(keyword: keyword)
        }
        return true
    }
}




