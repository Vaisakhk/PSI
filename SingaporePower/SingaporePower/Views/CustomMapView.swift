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
    }
    
    //MARK:- Populate Anotations
    func populateAnnotations(data:[PSIModel]) {
         var anotationArray:[MKPointAnnotation] = []
        for i in 0...data.count-1 {
            let psiModel = data[i]
            let tempAnotation = MKPointAnnotation()
            
            tempAnotation.coordinate = CLLocationCoordinate2D(latitude: psiModel.latittude, longitude: psiModel.longittude)
            anotationArray.append(tempAnotation)
        }
        DispatchQueue.main.async {
             self.addAnnotations(anotationArray)
        }
    }
    
    
}
