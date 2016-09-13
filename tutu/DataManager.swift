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
    //Получение данных
    class func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
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

//Функция парсинга JSON в массив 
class func parseData(direction: String) -> Array<CountrySity> {
    
    var sity: [CountrySity] = []
    DataManager.getDataFromFileWithSuccess { (data) in
        //JSON парсинг
        let json = JSON(data: data)
        if let sityArray = json[direction].array {
            for sityDict in sityArray {
                let countryTitle: String? = sityDict["countryTitle"].string
                let sityTitle: String? = sityDict["cityTitle"].string
                
                var stationArray1: [Station] = []
                
                if let stationArray = sityDict["stations"].array {
                    for stationDict in stationArray {
                        let stationTitle: String? = stationDict["stationTitle"].string
                        let countryTitle: String? = stationDict["countryTitle"].string
                        let districtTitle: String? = stationDict["districtTitle"].string
                        let cityTitle: String? = stationDict["cityTitle"].string
                        let regionTitle: String? = stationDict["regionTitle"].string
                        let station = Station(countryTitle: countryTitle!, districtTitle: districtTitle!, cityTitle: cityTitle!, regionTitle: regionTitle!, stationTitle: stationTitle!)
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
}
