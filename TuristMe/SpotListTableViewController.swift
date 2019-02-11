//
//  SpotListTableViewController.swift
//  TuristMe
//
//  Created by wizO on 22/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import Alamofire

class SpotListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        requestAlamofire()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spotList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpotList", for: indexPath) as? SpotTableViewCell else{
            return SpotTableViewCell()
        }
        
        cell.titleLBL.text = spotList[indexPath.row].addressSpot
        
        cell.commentaryLBL.text = spotList[indexPath.row].finishDate

        return cell
    }
    
    func requestAlamofire()
        
    {
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
            print("Alert OK")
        }
        
        let uRL = "http:localhost:8888/turistmeCAT/public/api/place"
        
        let _headers : HTTPHeaders = ["Authorization": token, "Content-type":"application/json"]
        
        Alamofire.request(uRL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: _headers).responseJSON{
            
            response in
            
            switch response.result {
                
            case .success:
                
                
                
                let respuesta = "\(response)"
                
                print(respuesta)
                
                switch respuesta{
                    
                    
                    
                case "SUCCESS: 204":
                    
                    let alertController = UIAlertController(title: "No hay lugares", message: "Aún no has añadido ningún lugar.", preferredStyle: .alert)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    break
                    
                default:
                    
                    let jsonPlaces = response.result.value
                    
                    let places = jsonPlaces as! [String:[[String:Any]]]
                    
                    spotList.removeAll()

                    for place in places["places"]!{
                        
                        spotList.append(Spot.init(json: place))
                        print(spotList.last?.comments)
                    }
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print("NO HE RECIBIDO RESPUESTA", error)
                
                break
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
