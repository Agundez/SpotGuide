//
//  Spot.swift
//  TuristMe
//
//  Created by wizO on 18/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import Foundation

class Spot : NSObject{
    
    var addressSpot : String
    var comments : String
    var startDate : String
    var finishDate : String
    var xCoord : Double
    var yCoord : Double
    
    init(adressSpot: String, comments : String, startDate : String, finishDate : String, xCoord : Double, yCoord : Double) {
        self.addressSpot = adressSpot
        self.comments = comments
        self.startDate = startDate
        self.finishDate = finishDate
        self.xCoord = xCoord
        self.yCoord = yCoord
    }
    
    init(json: [String : Any]){
        
        addressSpot = json["title"] as? String ?? ""
        comments = json["description"] as? String ?? ""
        startDate = json["startDate"] as? String ?? ""
        finishDate = json["endDate"] as? String ?? ""
        xCoord = (json["coordX"] as? Double)!
        yCoord = (json["coordY"] as? Double)!
        
    }
}
