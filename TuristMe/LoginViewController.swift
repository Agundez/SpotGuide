//
//  LoginViewController.swift
//  TuristMe
//
//  Created by wizO on 28/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userLoginTF: UITextField!
    @IBOutlet weak var passwordLoginTF: UITextField!
    
        let urlApi = "http://localhost:8888/turistmeCAT/public/api/login"
    
    var parameters : [String : String] = [
        "email" : "",
        "password" : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginTF.delegate = self
        passwordLoginTF.delegate = self

    }
    
    func reqAlamofire(){
        
        let _headers : HTTPHeaders = ["Content-type":"application/x-www-form-urlencoded"]
        Alamofire.request(urlApi, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: _headers).responseJSON {
            response in
            switch response.result{
            case .success:
                let respuesta = "\(response)"
                print(respuesta)
                switch respuesta{
                    
                case "SUCCESS: 204":
                    let alert = UIAlertController(title: "\(response)", message: "", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    print("Entrando en el caso 204")
                
                print("RESPUESTA BUENA",response)
                break
                
            case "SUCCESS: 401":
                print("He entrado en el caso 401")
                let alert = UIAlertController(title: "Datos incorrectos", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                break
                
            case "SUCCESS: 400":
                print("He entrado en el case 400")
                
                break
                
            default:
                var tokenResponse = response.value as! [String:String]
                token = "\(tokenResponse["token"]!)"
                    
//                 let goMap = self.storyboard?.instantiateViewController(withIdentifier: "MapSB")
//                self.present(goMap!, animated: true)
                self.performSegue(withIdentifier: "toTab", sender: self)
            }
                
            case .failure(let error):
                print("RESPUESTA MALA", response)
            }
        }
    }
    
    
    @IBAction func loginBTN(_ sender: Any) {
        let loginParameters: [String : String] = [
            "email" : userLoginTF.text!,
            "password" : passwordLoginTF.text!]
        
        parameters = loginParameters
        reqAlamofire()
    }
}
