//
//  AddSpotViewController.swift
//  TuristMe
//
//  Created by wizO on 18/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit

class AddSpotViewController: UIViewController {
    
    
    @IBOutlet weak var newAddressLBL: UILabel!
    
   var newAddress:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newAddressLBL.text = newAddress
        //adressLBL.text = Adress(newAdress: adress)[]
    }
    
    @IBAction func addSpot(_ sender: Any) {
        let addAdress = Spot(adressSpot: newAddress, comments: "", startDate: "", finishDate: "")
        
        spotList.append(addAdress)
    }
}
