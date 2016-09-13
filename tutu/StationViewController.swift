//
//  StationViewController.swift
//  tutu
//
//  Created by Дмитрий on 13.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class StationViewController: UIViewController {
    
    @IBOutlet weak var nameStation: UILabel!
    @IBOutlet weak var districtStation: UILabel!
    @IBOutlet weak var cityStation: UILabel!
    @IBOutlet weak var regionStation: UILabel!
    @IBOutlet weak var countryStation: UILabel!
    
    
    var station = Station(countryTitle: "", districtTitle: "", cityTitle: "", regionTitle: "", stationTitle: "")
    
    override func viewDidLoad() {
        nameStation.text = station.stationTitle
        districtStation.text = station.districtTitle
        cityStation.text = station.cityTitle
        regionStation.text = station.regionTitle
        countryStation.text = station.countryTitle
        super.viewDidLoad()
    }
    
}
