//
//  Spot.swift
//  TuristMe
//
//  Created by wizO on 18/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import Foundation

class Spot{
    
    var addressSpot : String
    var comments : String
    var startDate : String
    var finishDate : String
    
    init(adressSpot: String, comments : String, startDate : String, finishDate : String) {
        self.addressSpot = adressSpot
        self.comments = comments
        self.startDate = startDate
        self.finishDate = finishDate
    }
}
