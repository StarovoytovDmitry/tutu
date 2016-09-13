//
//  ViewController.swift
//  tutu
//
//  Created by Дмитрий on 08.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stationsTableView: UITableView!
    
    let arrayStations = parseData("citiesFrom")
    
    override func viewDidLoad() {
        //print(parseData("citiesFrom"))
        stationsTableView.delegate = self
        stationsTableView.dataSource = self
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayStations.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayStations[section].stations.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("Sity: \(arrayStations[section].sityTitle)") + (" Country: \(arrayStations[section].countryTitle)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "StationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StationTableViewCell
        cell.nameStation.text = arrayStations[indexPath.section].stations[indexPath.row].stationTitle
        return cell
    }
    
}

