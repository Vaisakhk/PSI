//
//  ViewController.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

import PKHUD

class ViewController: BaseViewController {
    
    @IBOutlet weak var mapView: CustomMapView!
    @IBOutlet weak var refreshButton: UIButton!
    
    let errorMessage =  "message"
    
    let name =  "name"
    let items = "items"
    let readings = "readings"
    let latitude =  "latitude"
    let longitude = "longitude"
    let regionMetadata =  "region_metadata"
    let labelLocation =  "label_location"
    
    let coSubIndex = "co_sub_index"
    let o3SubIndex = "o3_sub_index"
    let pm10SubIndex = "pm10_sub_index"
    let so2SubIndex = "so2_sub_index"
    let pm25SubIndex = "pm25_sub_index"
    let no2OneHourMax = "no2_one_hour_max"
    let o3EightHourMax = "o3_eight_hour_max"
    let coEightHourMax = "co_eight_hour_max"
    let so2TwentyFourHourly = "so2_twenty_four_hourly"
    let psiTwentyFourHourly = "psi_twenty_four_hourly"
    let pm25TwentyFourHourly = "pm25_twenty_four_hourly"
    let pm10TwentyFourHourly = "pm10_twenty_four_hourly"
    
    //MARK:- View Life Cycle
    override func initView() {
        super.initView()
        
        getPSiDetails()
    }
    
    //MARK:- GET PSI Details
    func getPSiDetails() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: self.mapView)
        let dateTime =  CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: Date(), formatedString: "YYYY-MM-dd'T'HH:mm:ss", timezone: TimeZone.current)
        let date =  CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: Date(), formatedString: "YYYY-MM-dd", timezone: TimeZone.current)
        let urlString = String(format: "%@date_time=%@&date=%@", Constants.Api.BASEURL,dateTime,date)
        let headerData:[String:String] = RequestHeaderGenerator.sharedInstance.headerBody()
        let netWorkHandler:NetworkHandler = NetworkHandler().initWithRequest(requestUrl: URL(string: urlString)!, data: nil, methodType: .MethodTypeGET, headerDictionary: headerData);
        netWorkHandler.startServieRequest(success: { (response, statusCode) in
            DispatchQueue.main.async {
                PKHUD.sharedHUD.hide()
                if let datas:[String : AnyObject] = response as? [String : AnyObject] {
                    if statusCode == 200 {
                        self.mapView.populateAnnotations(data: self.createDate(data: datas))
                    }else {
                        self.processAlert(message: datas[self.errorMessage] as! String)
                    }
                }else {
                    self.processAlert(message: Constants.AlertMessage.noDataAvailable)
                }
            }
        }) { (error, statuscode, erroResponse) in
            DispatchQueue.main.async {
                PKHUD.sharedHUD.hide()
                if(statuscode == 1024) {
                    self.processAlert(message: error.localizedDescription)
                }else {
                    self.processAlert(message: Constants.AlertMessage.errorNetworkFailed)
                }
            }
        }
    }
    
    //MARK:- Create PSI Model
    func createDate(data:[String : AnyObject]) -> [PSIModel]  {
        var annotationDetails:[PSIModel] = []
        if let regionData:[[String : AnyObject]] =  data[regionMetadata] as? [[String : AnyObject]] {
            for i in 0...regionData.count-1 {
                let psiMOdel = PSIModel()
                psiMOdel.name = regionData[i][name] as! String
                psiMOdel.latittude = regionData[i][labelLocation]![latitude] as! Double
                psiMOdel.longittude = regionData[i][labelLocation]![longitude] as! Double
                if let itemData:[[String : AnyObject]] =  data[items] as? [[String : AnyObject]] {
                    for j in 0...itemData.count-1 {
                        psiMOdel.detail =  populateReadings(data: itemData[j], model: psiMOdel)
                    }
                }
                annotationDetails.append(psiMOdel)
            }
        }
        return annotationDetails
    }
    
    //MARK:- Create PSI Readings
    func populateReadings(data:[String : AnyObject], model:PSIModel) -> PSIDetail {
        let modelDetail = PSIDetail()
        if let readingsData:[String : AnyObject] =  data[readings] as? [String : AnyObject] {
            modelDetail.o3SubIndex = readingsData[o3SubIndex]![model.name] as! Double
            modelDetail.pm10TwentyFourHourly = readingsData[pm10TwentyFourHourly]![model.name] as! Double
            modelDetail.pm10SubIndex = readingsData[pm10SubIndex]![model.name] as! Double
            modelDetail.coSubIndex = readingsData[coSubIndex]![model.name] as! Double
            modelDetail.pm25TwentyFourHourly = readingsData[pm25TwentyFourHourly]![model.name] as! Double
            modelDetail.so2SubIndex = readingsData[so2SubIndex]![model.name] as! Double
            modelDetail.coEightHourMax = readingsData[coEightHourMax]![model.name] as! Double
            modelDetail.no2OneHourMax = readingsData[no2OneHourMax]![model.name] as! Double
            modelDetail.so2TwentyFourHourly = readingsData[so2TwentyFourHourly]![model.name] as! Double
            modelDetail.pm25SubIndex = readingsData[pm25SubIndex]![model.name] as! Double
            modelDetail.psiTwentyFourHourly = readingsData[psiTwentyFourHourly]![model.name] as! Double
            modelDetail.o3EightHourMax = readingsData[o3EightHourMax]![model.name] as! Double
        }
        return modelDetail
    }
    
    //MARK:- UIView Action
    @IBAction func refreshButtonAction(_ sender: Any) {
        getPSiDetails()
    }
    
    //MARK:- Process Alert
    func processAlert(message:String) {
        CLAlertHandler().showAlert(alertMessage: message, title: Constants.appName, contoller: self) { (isSuccess) in
            
        }
    }
}

