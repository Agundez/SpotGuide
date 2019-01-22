//
//  MapViewController.swift
//  TuristMe
//
//  Created by wizO on 16/01/2019.
//  Copyright © 2019 Carlos Agundez Torres. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    let geocoder = CLGeocoder()
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.action(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    

    @IBAction func locationUser() {
        initLocation()
    }
    
    func initLocation(){
        let permission = CLLocationManager.authorizationStatus()
        
        if permission == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if permission == .denied{
            alertLocation(tit: "Error in the location", men: "Currently the location of the device is denied.")
        }else if permission == .restricted{
            alertLocation(tit: "Error in the location", men: "Currently the location of the device is restricted.")
        }else{
            guard let currentCoordinate = locationManager.location?.coordinate else{return}
            
            let region = MKCoordinateRegion(center: currentCoordinate,latitudinalMeters: 500,longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func alertLocation(tit: String, men: String){
        let alert = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Acept", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func action(gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
       // let latitude = String(format: "%.6f", newCoords.latitude)
       // let longitude = String(format: "%.6f", newCoords.longitude)
        
        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoords
        annotation.title = address
        
        mapView.addAnnotation(annotation)
        
        print(address)
        
    }

    func geocoderLocation(newLocation: CLLocation){
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        var dir = ""
        geocoder.reverseGeocodeLocation(newLocation){(placemarks,error) in
            if error == nil{
                dir = "The adress could not be determined"
            }
            if let placemark = placemarks?.last{
                dir = self.stringFromPlacemark(placemark: placemark)
            }
            self.address = dir
           // print(dir)
        }
    }
    
    func stringFromPlacemark(placemark: CLPlacemark)->String{
        var line = ""
        
        if let p = placemark.thoroughfare{
            line += p + ","
        }
        if let p = placemark.subThoroughfare{
            line += p + ""
        }
        if let p = placemark.locality{
            line += " (" + p + ")"
        }
        return line
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAddressSegue"{
            let addSpotView = segue.destination as! AddSpotViewController
            addSpotView.newAddress = address
        }
    }
    
    
    @IBAction func addSpot(_ sender: Any) {
 //   let addAdress = Spot(adressSpot: , comments: "", startDate: "", finishDate: "")

     //  spotList.append(addAdress)

       // var newAdress = Adress(newAdress: adress)
       // print(newAdress)

       //adress = Adress(newAdress: adress)
     //   print(address)
     //  dump(address)

   }
    
}


extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
    }
}

extension MapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationID = "AnnotationID"
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID){
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }else{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
        }
        
        if let annotationView = annotationView{
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "maps-and-flags")
        }
        return annotationView
    }
    
    
    
}
