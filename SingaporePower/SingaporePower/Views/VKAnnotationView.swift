//
//  ViewController.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//


import UIKit
import MapKit

private let kPersonMapAnimationTime = 0.300

class VKAnnotationView: MKAnnotationView {
    
    var psiModel:PSIModel?
    weak var customCalloutView: CustomPopupView?
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    // MARK: - life cycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        self.image = UIImage(named: "mapPin")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
         self.image = UIImage(named: "mapPin")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview()
            if let newCustomCalloutView = loadCustomMapView() {
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: kPersonMapAnimationTime, animations: { 
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else {
            if customCalloutView != nil {
                if animated {
                    UIView.animate(withDuration: kPersonMapAnimationTime, animations: { 
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() }
            }
        }
    }
    
    func loadCustomMapView() -> CustomPopupView? {
        if let views = Bundle.main.loadNibNamed("CustomPopupView", owner: self, options: nil) as? [CustomPopupView], views.count > 0 {
            let personDetailMapView = views.first!
            personDetailMapView.populatePSIReadings(readings: psiModel?.detail)
            return personDetailMapView
        }
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
}
