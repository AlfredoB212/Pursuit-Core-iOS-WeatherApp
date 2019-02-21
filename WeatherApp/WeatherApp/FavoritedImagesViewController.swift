//
//  FavoritedImagesViewController.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritedImagesViewController: ViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteImages = DataPersistanceModel.getImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteImages = DataPersistanceModel.getImages()
        favoriteTableView.reloadData()
    }
}
extension FavoritedImagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavoriteImageTableViewCell else {return UITableViewCell()}
        let favoriteImageToSet = favoriteImages[indexPath.row]
        if let imageData = UIImage(data: favoriteImageToSet.imageData){
            cell.favoritedImages.image = imageData
        }
        return cell
    }
}
extension FavoritedImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
    




