//
//  RegisterViewController.swift
//  TuristMe
//
//  Created by wizO on 28/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
   // let registerVC = RegisterViewController
    let urlApi = "http://localhost:8888/turistmeCAT/public/api/user"
    
    var parameters : [String : String] = [
        "name" : "",
        "password" : "",
        "passwordConfirmed" : "",
        "email" : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        repeatPasswordTF.delegate = self
        
    }
    

    @IBAction func registerBTN(_ sender: Any) {
        
        
        let registerParameters: [String : String] = [
            "name" : userTF.text!,
            "password" : passwordTF.text!,
            "passwordConfirmed" : repeatPasswordTF.text!,
            "email" : emailTF.text!]
        
        parameters = registerParameters
         reqAlamofire()
    }
    
    func reqAlamofire(){
        
        let _headers : HTTPHeaders = ["Content-type":"application/x-www-form-urlencoded"]
        Alamofire.request(urlApi, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: _headers).responseJSON {
            response in
            switch response.result{
            case .success:
                print("RESPUESTA BUENA",response)
                //registerVC.dismiss(animated: true, completion: nil)
                
        let alert = UIAlertController(title: "Usuario creado correctamente", message: "Ve a la pantalla de login para iniciar la aplicación", preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
        self.present(alert, animated: true)
                
                break
            case .failure(let error):
                print("RESPUESTA MALA", response)
            }
        }
    }
}
