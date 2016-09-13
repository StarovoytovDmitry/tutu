//
//  TabletimeViewController.swift
//  tutu
//
//  Created by Дмитрий on 13.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class TabletimeViewController: UIViewController, StationsViewControllerDelegate {
    
    var selectedStation: String = "" //Выбранная станция
    var fromDirection: Bool = true //Направление
    
    @IBOutlet weak var stationFrom: UILabel! //Станция откуда
    @IBOutlet weak var stationTo: UILabel! //Станция куда
    
    @IBAction func stationsFrom(sender: AnyObject) {
        fromDirection = true
    }
    @IBAction func stationsTo(sender: AnyObject) {
        fromDirection = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Обновить выбранную станцию
    func updateStation(station: String, from: Bool) {
        if fromDirection == true {
            stationFrom.text = station
            self.selectedStation = station
        } else {
            stationTo.text = station
            self.selectedStation = station
        }
        self.selectedStation = station
        self.reloadInputViews()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? StationsViewController {
            controller.delegate = self
            controller.fromDirection = fromDirection
        }
    }
}
