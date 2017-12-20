//
//  SurfSpots.swift
//  MagicPorpoise
//
//  Created by Will Dailey on 12/4/17.
//  Copyright © 2017 Will Dailey. All rights reserved.
//

import Foundation

struct surfSpot {
    var name: String!
    var spotID: String!
    var dateData: [DateData]?
}

class SurfSpots {
    
    var surfSpots: [surfSpot] = []
    init() {
        let spot1 = surfSpot(name: "Jenness Beach", spotID: "?spot_id=881", dateData: nil)
        let spot2 = surfSpot(name: "Rye Rocks", spotID: "?spot_id=368", dateData: nil)
        let spot3 = surfSpot(name: "The Wall", spotID: "?spot_id=369", dateData: nil)
        surfSpots.append(spot1)
        surfSpots.append(spot2)
        surfSpots.append(spot3)
    }
    
    func getSpots() -> [surfSpot] {
        return surfSpots
    }
    
}
