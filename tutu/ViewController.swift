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

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var stationsTableView: UITableView!
    
    var fromDirection: Bool = true //Направление
    var arrayStations = [CountrySity]() //Массив городов
    var selectedStation: String = "" //Выбранная станция
    var delegate: StationsViewControllerDelegate?
    
    var resultSearchController: UISearchController!
    var filteredData = [CountrySity]()
    
    override func viewDidLoad() {
        
        if fromDirection == true {
            arrayStations = DataManager.parseData("citiesFrom")
        } else {
            arrayStations = DataManager.parseData("citiesTo")
        }
        stationsTableView.delegate = self
        stationsTableView.dataSource = self
        super.viewDidLoad()
        
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        resultSearchController.searchBar.sizeToFit()
        self.stationsTableView.tableHeaderView = resultSearchController.searchBar
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if resultSearchController.active {
            return filteredData.count
        }
        else {
            return arrayStations.count
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active {
            return filteredData[section].stations.count
        }
        else {
            return arrayStations[section].stations.count
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if resultSearchController.active {
            return ("Sity: \(filteredData[section].sityTitle)") + (" Country: \(filteredData[section].countryTitle)")
        }
        else {
            return ("Sity: \(arrayStations[section].sityTitle)") + (" Country: \(arrayStations[section].countryTitle)")
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Отображение ячейки станции
        let cellIdentifier = "StationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StationTableViewCell
        var selectStation = ""
        if resultSearchController.active {
            selectStation = filteredData[indexPath.section].stations[indexPath.row].stationTitle
        }
        else {
            selectStation = arrayStations[indexPath.section].stations[indexPath.row].stationTitle
        }
        cell.nameStation.text = selectStation
        return cell
        
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var station: Station
        if resultSearchController.active {
            station = filteredData[indexPath.section].stations[indexPath.row]
        }
        else {
            station = arrayStations[indexPath.section].stations[indexPath.row]
        }
        //let station = arrayStations[indexPath.section].stations[indexPath.row]
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
    
    //MARK: UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if searchController.searchBar.text?.characters.count > 0 {
            filteredData.removeAll(keepCapacity: false)
            let searchPredicate = NSPredicate(format: "stationTitle CONTAINS[cd] %@", searchController.searchBar.text!)
            for city in arrayStations {
                
                let array = (city.stations as NSArray).filteredArrayUsingPredicate(searchPredicate)
                let array1 = array as! [Station]
                    //filteredData.append(city)
                    //print(array1)
                    for i in array1 {
                        filteredData.append(city)
                        print(i.stationTitle)
                    }
            }
            //print(filteredData)
            stationsTableView.reloadData()
        }
        else {
            filteredData.removeAll(keepCapacity: false)
            filteredData = arrayStations
            stationsTableView.reloadData()
        }
    }
}
