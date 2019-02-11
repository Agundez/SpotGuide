//
//  AddSpotViewController.swift
//  TuristMe
//
//  Created by wizO on 18/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import Alamofire

class AddSpotViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var newAddressLBL: UILabel!
    @IBOutlet weak var sinceDatePicker: UIDatePicker!
    @IBOutlet weak var untilDatePicker: UIDatePicker!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var commentaryTF: UITextField!
    
   var newAddress:String = ""
    var coordX:Double = 0
    var coordY:Double = 0
    var sinceDate:String = ""
    var untilDate:String = ""
    
    let urlApi = "http://localhost:8888/turistmeCAT/public/api/place"
    
    var parameters : [String : Any] = [
        "title" : "",
        "description" : "",
        "startDate" : "",
        "endDate" : "",
        "coordX" : 0,
        "coordY" : 0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newAddressLBL.text = newAddress
        
        titleTF.delegate = self
        commentaryTF.delegate = self
        
        //adressLBL.text = Adress(newAdress: adress)[]
    }
    
    func checkTF(){
        if(titleTF.text?.isEmpty ?? true){
            let alert = UIAlertController(title: "You need to fill in the tittle field", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func reqAlamofire(){
        
        let _headers : HTTPHeaders = ["Authorization":token]
        Alamofire.request(urlApi, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: _headers).responseString {
            response in
            switch response.result{
            case .success:
                print("RESPUESTA BUENA",response)
                
                break
            case .failure(let error):
                print("RESPUESTA MALA", error)
            }
        }
    }
    
    
    @IBAction func sinceDP(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var startDate = dateFormatter.string(from: sinceDatePicker.date)
        self.sinceDate = startDate
    }
    
    @IBAction func untilDP(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var finishDate = dateFormatter.string(from: untilDatePicker.date)
        self.untilDate = finishDate
    }
    
    
    @IBAction func addSpot(_ sender: Any) {
//        let addAdress = Spot(adressSpot: newAddress, comments: "", startDate: "", finishDate: "")
//
//        spotList.append(addAdress)
//
        checkTF()
        
        let addSpotParameters: [String : Any] = [
            "title" : titleTF.text!,
            "description" : commentaryTF.text!,
            "startDate" : sinceDate,
            "endDate" : untilDate,
            "coordX" : coordX,
            "coordY" : coordY]
        
        parameters = addSpotParameters
        reqAlamofire()
        
        self.performSegue(withIdentifier: "addToTab", sender: self)

        
        print(coordY)
        print(coordX)
    }
}
