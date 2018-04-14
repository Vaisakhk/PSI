//
//  CustomPopupView.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class CustomPopupView: UIView {
    @IBOutlet weak var os3SubLabel: UILabel!
    @IBOutlet weak var pm10label: UILabel!
    @IBOutlet weak var pm10subLabel: UILabel!
    @IBOutlet weak var coSubLabel: UILabel!
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var so2Label: UILabel!
    @IBOutlet weak var coeightLabel: UILabel!
    @IBOutlet weak var no2OneLabel: UILabel!
    @IBOutlet weak var pm25subLabel: UILabel!
    @IBOutlet weak var psiTwentyLabel: UILabel!
    @IBOutlet weak var os3EightLabel: UILabel!
    
    @IBOutlet weak var so2TwentyHourLabel: UILabel!
    @IBOutlet weak var psiTwentyFourLabel: UILabel!
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }
    
    //MARK:- View Data populate
    func populatePSIReadings(readings:PSIDetail?) {
        if let data = readings {
            os3SubLabel.text = String(format: "%.0f", data.o3SubIndex)
            pm10label.text = String(format: "%.0f", data.pm10TwentyFourHourly)
            pm10subLabel.text = String(format: "%.0f", data.pm10SubIndex)
            coSubLabel.text = String(format: "%.0f", data.coSubIndex)
            pm25Label.text = String(format: "%.0f", data.pm25TwentyFourHourly)
            so2TwentyHourLabel.text = String(format: "%.0f", data.so2TwentyFourHourly)
            so2Label.text = String(format: "%.0f", data.so2SubIndex)
            coeightLabel.text = String(format: "%.0f", data.coEightHourMax)
            no2OneLabel.text = String(format: "%.0f", data.no2OneHourMax)
            pm25subLabel.text = String(format: "%.0f", data.pm25SubIndex)
            os3EightLabel.text = String(format: "%.0f", data.o3SubIndex)
            psiTwentyFourLabel.text = String(format: "%.0f", data.psiTwentyFourHourly)
        }
    }
    
}
