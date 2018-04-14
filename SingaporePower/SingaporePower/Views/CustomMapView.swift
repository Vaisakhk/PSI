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

    //MARK:- View Life cycle
    override func awakeFromNib() {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1.35735, longitude: 103.82)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate,MKCoordinateSpanMake(0.4, 0.4))
        self.setRegion(region, animated: true)
        self.delegate = self
    }
    
    //MARK:- Populate Anotations
    func populateAnnotations(data:[PSIModel]) {
         var anotationArray:[MKPointAnnotation] = []
        for i in 0...data.count-1 {
            let psiModel = data[i]
            let tempAnotation = MKPointAnnotation()
            tempAnotation.title = psiModel.name
            tempAnotation.subtitle = "Vaisakh krishnan Poovathummoottil House Pezhumpar p o Vadassrikara"
            tempAnotation.coordinate = CLLocationCoordinate2D(latitude: psiModel.latittude, longitude: psiModel.longittude)
            anotationArray.append(tempAnotation)
        }
        DispatchQueue.main.async {
             self.addAnnotations(anotationArray)
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    }
    
//    override func view(for annotation: MKAnnotation) -> MKAnnotationView? {
//        let pinAnotation:MKPinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "loc")
//        return pinAnotation
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    

}
