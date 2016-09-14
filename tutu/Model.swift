//
//  Model.swift
//  tutu
//
//  Created by Дмитрий on 12.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import UIKit

class CountrySity: NSObject {
    
    let countryTitle: String
    let sityTitle: String
    let stations: [Station]
    
    override var description: String {
        return "Country: \(countryTitle), Sity: \(sityTitle), Stations: \(stations)\n"
    }
    
    init(countryTitle: String, sityTitle: String, stations: [Station]) {
        self.countryTitle = countryTitle ?? ""
        self.sityTitle = sityTitle ?? ""
        self.stations = stations
    }
}

class Station: NSObject {
    
    let countryTitle: String
    let districtTitle: String
    let cityTitle: String
    let regionTitle: String
    let stationTitle: String
    
    init(countryTitle: String, districtTitle: String, cityTitle: String, regionTitle: String, stationTitle: String) {
        self.countryTitle = countryTitle
        self.districtTitle = districtTitle
        self.cityTitle = cityTitle
        self.regionTitle = regionTitle
        self.stationTitle = stationTitle
    }
}


