//
//  MainViewController.swift
//  TableView My places
//
//  Created by Андрей Шевчук on 17.01.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit
import RealmSwift
class MainViewController: UITableViewController {

   
    
    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        places = realm.objects(Place.self)
    }

    // MARK: - Table view data source

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return places.isEmpty ? 0: places.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]
        
        cell.nameLabel?.text = place.name
        cell.typeLabel.text = place.type
        cell.locationLabel.text = place.location
        cell.placesImage.image = UIImage(data: place.imageData!)
        cell.placesImage?.layer.cornerRadius = cell.placesImage.frame.size.height / 2
        cell.placesImage?.clipsToBounds = true
        return cell
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        if editingStyle == .delete{
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else{
            //
        }
    }
    
    
    
   @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        newPlaceVC.saveNewPlace()
        tableView.reloadData()
    }
}
