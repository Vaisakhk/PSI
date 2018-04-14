//
//  ViewController.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func initView() {
        super.initView()
        
        getPSiDetails()
    }

    func getPSiDetails() {
      let dateTime =  CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: Date(), formatedString: "YYYY-MM-dd'T'HH:mm:ss", timezone: TimeZone.current)
        let date =  CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: Date(), formatedString: "YYYY-MM-dd", timezone: TimeZone.current)
        let urlString = String(format: "%@date_time=%@&date=%@", Constants.Api.BASEURL,dateTime,date)
        let headerData:[String:String] = RequestHeaderGenerator.sharedInstance.headerBody()
        let netWorkHandler:NetworkHandler = NetworkHandler().initWithRequest(requestUrl: URL(string: urlString)!, data: nil, methodType: .MethodTypeGET, headerDictionary: headerData);
        netWorkHandler.startServieRequest(success: { (response, statusCode) in
            if statusCode == 200 {
                let data:[String : AnyObject] = response as! [String : AnyObject]
               
            }else {
               
            }
        }) { (error, statuscode, erroResponse) in
            if(statuscode == 1024) {
             
            }else {
             
            }
        }
    }
   
}

