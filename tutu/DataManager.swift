//
//  DataManager.swift
//  tutu
//
//  Created by Дмитрий on 12.09.16.
//  Copyright © 2016 Dmitry. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    
    class func getTopAppsDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let filePath = NSBundle.mainBundle().pathForResource("allStations",ofType:"json")
            
            do {
                let data = try NSData(contentsOfFile:filePath!,
                    options: NSDataReadingOptions.DataReadingUncached)
                success(data: data)
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            } catch {
                fatalError()
            }
        //})
    }
}

func parseData(direction: String) -> Array<CountrySity> {
    
    var sity: [CountrySity] = []
    DataManager.getTopAppsDataFromFileWithSuccess { (data) in
        
        let json = JSON(data: data)
        if let sityArray = json[direction].array {
            for sityDict in sityArray {
                let countryTitle: String? = sityDict["countryTitle"].string
                let sityTitle: String? = sityDict["cityTitle"].string
                
                var stationArray1: [Stations] = []
                
                if let stationArray = sityDict["stations"].array {
                    for stationDict in stationArray {
                        let stationTitle: String? = stationDict["stationTitle"].string
                        let station = Stations(stationTitle: stationTitle!)
                        stationArray1.append(station)
                    }
                }
                
                let sitycountry = CountrySity(countryTitle: countryTitle!, sityTitle: sityTitle!, stations: stationArray1)
                sity.append(sitycountry)
            }
        }
    }
    return(sity)
    
}
