//
//  ViewController.swift
//  tutu
//
//  Created by Дмитрий on 08.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

protocol StationsViewControllerDelegate {
    func updateStation(station: String, from: Bool)
}

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stationsTableView: UITableView!
    
    var fromDirection: Bool = true //Направление
    var arrayStations = [CountrySity]() //Массив станций
    var selectedStation: String = "" //Выбранная станция
    var delegate: StationsViewControllerDelegate?
    
    override func viewDidLoad() {
        
        if fromDirection == true {
            arrayStations = DataManager.parseData("citiesFrom")
        } else {
            arrayStations = DataManager.parseData("citiesTo")
        }
        stationsTableView.delegate = self
        stationsTableView.dataSource = self
        super.viewDidLoad()
        
    }
    
    //MARK: UITableViewDataSource
    
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
        //Отображение ячейки станции
        let cellIdentifier = "StationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StationTableViewCell
        let selectStation = arrayStations[indexPath.section].stations[indexPath.row].stationTitle
        cell.nameStation.text = selectStation
        return cell
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let station = arrayStations[indexPath.section].stations[indexPath.row]
        selectedStation = station.stationTitle
        delegate?.updateStation(selectedStation, from: fromDirection)
        
        //переход на информацию о станции
        self.performSegueWithIdentifier("stationInfo", sender: station)
        
    }
    
    //MARK: Data send
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? StationViewController {
            controller.station = sender as! Station
        }
    }
    
}
