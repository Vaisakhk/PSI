//
//  CustomMapView.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

import MapKit

class CustomMapView: MKMapView ,MKMapViewDelegate {
    var dataArray:[PSIModel] = []
    
    //MARK:- View Life cycle
    override func awakeFromNib() {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.35735, longitude: 103.82)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate,MKCoordinateSpanMake(0.4, 0.4))
        self.setRegion(region, animated: true)
        self.delegate = self
    }
    
    //MARK:- Populate Anotations
    func populateAnnotations(data:[PSIModel]) {
        dataArray.append(contentsOf: data)
         var anotationArray:[MKPointAnnotation] = []
        for i in 0...data.count-1 {
            let psiModel = data[i]
            let tempAnotation = MKPointAnnotation()
            tempAnotation.title = psiModel.name
            tempAnotation.coordinate = CLLocationCoordinate2D(latitude: psiModel.latittude, longitude: psiModel.longittude)
            anotationArray.append(tempAnotation)
        }
        DispatchQueue.main.async {
             self.addAnnotations(anotationArray)
        }
    }
    
    //MARK:- MKMap View Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "vk") {
//            annotationView.annotation = annotation
//            return annotationView
//        } else {
//            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"vk")
//            annotationView.isEnabled = true
//            annotationView.canShowCallout = false
//            let v = UIView()
//            v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            v.tag = 1000
//            v.isHidden = true;
//            annotationView.addSubview(v)
//            let btn = UIButton(type: .detailDisclosure)
//            annotationView.rightCalloutAccessoryView = btn
//            return annotationView
//        }
        var annotationView:VKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "kAnnotationName") as? VKAnnotationView
        
        if annotationView == nil {
            annotationView = VKAnnotationView(annotation: annotation, reuseIdentifier: "kAnnotationName")
            annotationView?.psiModel = getPSIModelWithName(name: annotation.title as? String)
            
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }

     //MARK:- Get PSI Model With Name
    func getPSIModelWithName(name:String?) -> PSIModel? {
        for i in 0..<dataArray.count {
            if(dataArray[i].name == name) {
                return dataArray[i]
            }
        }
//        let predicate = NSPredicate(format: "name MATCHES %@", name!)
//        let filteredArray = dataArray.filter { predicate.evaluate(with: $0) }
//        if(filteredArray.count != 0) {
//           return filteredArray[0]
//        }
        return nil
    }
}
