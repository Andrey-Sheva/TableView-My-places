//
//  MainViewController.swift
//  TableView My places
//
//  Created by Андрей Шевчук on 17.01.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let restaurentNames = ["Колиба","Старий йорк","Аура","Чілі піцца","Шок","Бочка","Баварія"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return restaurentNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel?.text = restaurentNames[indexPath.row]
        cell.placesImage?.image = UIImage(named: "food")
        cell.placesImage?.layer.cornerRadius = cell.placesImage.frame.size.height / 2
        cell.placesImage?.clipsToBounds = true
        return cell
    }
    
    // MARK: - TableView delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
