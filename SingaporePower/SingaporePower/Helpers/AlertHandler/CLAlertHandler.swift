//
//  CLAlertHandler.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

let ALERTOKTITLE = "Ok";

public var sharedHandlerInsatnce = CLAlertHandler()

public class CLAlertHandler: NSObject {
    
    // MARK: Local Variable
    public final class sharedInstance {
        private init() { }
        static let shared = CLAlertHandler()
    }
    
    public func showAlert(alertMessage:String,title:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            let ok  = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                successBlock(true)
            }
            alert.addAction(ok)
            contoller.present(alert, animated: true, completion: nil);
        }
    }
    
    
    public func showAlertWithButtons(alertMessage:String,title:String,successButtonTitle:String,cancelButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ isSuccess:Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            let ok  = UIAlertAction(title: successButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(true)
            }
            alert.addAction(ok)
            let cancel  = UIAlertAction(title: cancelButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(false)
            }
            alert.addAction(cancel)
            contoller.present(alert, animated: true, completion: nil);
        }
    }
    
    public func showAlertWithThreeButtons(alertMessage:String,title:String,firstButtonTitle:String,secondButtonTitle:String,thirdButtonTitle:String,contoller:UIViewController,successBlock: @escaping (_ successTitle:String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            let ok  = UIAlertAction(title: firstButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(firstButtonTitle)
            }
            alert.addAction(ok)
            let cancel  = UIAlertAction(title: secondButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(secondButtonTitle)
            }
            alert.addAction(cancel)
            let third  = UIAlertAction(title: thirdButtonTitle, style: .default) { (UIAlertAction) in
                successBlock(thirdButtonTitle)
            }
            alert.addAction(third)
            contoller.present(alert, animated: true, completion: nil);
        }
    }
    
    public func showAlertWithMoreButtons(alertMessage:String,title:String,buttonTitles:Array<Any>,contoller:UIViewController,successBlock: @escaping (_ successTitle:String) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
            for actionTitle in buttonTitles {
                let alertAction  = UIAlertAction(title: actionTitle as? String, style: .default) { (UIAlertAction) in
                    successBlock(actionTitle as! String)
                }
                alert.addAction(alertAction)
            }
            
            contoller.present(alert, animated: true, completion: nil);
        }
    }
}
