//
//DateDetail.swift
//MagicPorpoise
//
//Created by Will Dailey on 12/2/17.
//Copyright © 2017 Will Dailey. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON


struct DateData {
    var spotID: String = ""
    
    var date: String = ""
    var time: String = ""
    
    var solidRating: Double!
    var fadedRating: Double!
    
    var minWaveHeight: Double!
    var maxWaveHeight: Double!
    
    var swellDirection: String!
    var swellPeriod: Double!
    
    var windSpeed: Double!
    var windDirection: String!
    
    var airTemp: Double!
    
    var inputField: String!
    
    init() {
        self.spotID = ""
        self.date = ""
        self.time  = ""
        self.solidRating = 0.0
        self.fadedRating = 0.0
        self.minWaveHeight = 0.0
        self.maxWaveHeight = 0.0
        self.swellDirection = ""
        self.swellPeriod = 0.0
        self.windSpeed = 0.0
        self.windDirection = ""
        self.airTemp = 0.0
        self.inputField = ""
    }
    
    init(spotID: String, date: String, time: String, solidRating: Double, fadedRating: Double, minWaveHeight: Double, maxWaveHeight: Double, swellDirection: String, swellPeriod: Double, windSpeed: Double, windDirection: String, airTemp: Double!, inputField: String!) {
        self.spotID = spotID
        self.date = date
        self.time = time
        self.solidRating = solidRating
        self.fadedRating = fadedRating
        self.minWaveHeight = minWaveHeight
        self.maxWaveHeight = maxWaveHeight
        self.swellDirection = swellDirection
        self.swellPeriod = swellPeriod
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.airTemp = airTemp
        self.inputField = inputField
    }
}

class DateDetail {
    var apiCall1 = "http://magicseaweed.com/api/"
    var apiKey = "e8db1c71647e7241e5db73dd776b8c21"
    var apiCall2 = "/forecast/"
    var usUnits = "&units=us"
    
    init() {
        
    }
    
    func getData(_ spotID: String, completed: @escaping (DateData) -> () ) {
        let msAPI = "\(apiCall1)\(apiKey)\(apiCall2)\(spotID)\(usUnits)"
        Alamofire.request(msAPI).responseJSON {response in
            var dateData = DateData()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                dateData.spotID = spotID
                (dateData.time, dateData.date) = self.prepareDateTimeValues()
                dateData.solidRating = json[0]["solidRating"].doubleValue
                dateData.fadedRating = json[0]["fadedRating"].doubleValue
                dateData.minWaveHeight = json[0]["swell"]["minBreakingHeight"].doubleValue
                dateData.maxWaveHeight = json[0]["swell"]["maxBreakingHeight"].doubleValue
                dateData.swellDirection = json[0]["swell"]["components"]["combined"]["compassDirection"].stringValue
                dateData.swellPeriod = json[0]["swell"]["components"]["combined"]["period"].doubleValue
                dateData.windSpeed = json[0]["wind"]["speed"].doubleValue
                dateData.windDirection = json[0]["wind"]["compassDirection"].stringValue
                dateData.airTemp = json[0]["wind"]["chill"].doubleValue
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url")
            }
            completed(dateData)
        }
    }
    
    func prepareDateTimeValues() -> (String, String) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let currentTime = "\(hour):\(minutes)"
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let currentDate = "\(month)/\(day)/\(year)"
        return (currentTime, currentDate)
    }
}
