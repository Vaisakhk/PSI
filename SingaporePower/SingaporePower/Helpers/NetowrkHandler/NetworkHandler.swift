//
//  NetworkHandler.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

import Alamofire

let CLNetworkErrorMessage = "Please check your network connection, and try again."

public class NetworkHandler: NSObject {
    
   public static let sharedInstance = NetworkHandler()
    
    var url :URL!
    var bodyData :AnyObject?
    var methodTyeData :Alamofire.HTTPMethod!
    var headerDictionaryData : [String: String]?
    var urlRequest : NSMutableURLRequest!
    
    //MARK: Networking initialisation
    /**
     *  Networking initialized
     *
     *  @param   requestUrl           : Requesting URL
     *           data                 : Request parameters
     *           METHODTYPE           : HTTP Method type
     *           headerDictionary     : HTTP Header Dictionary
     *  @Return  instance of NetworkHandler class
     */

    public func networkUnavalible() -> Bool{
        var isReachable:Bool = true;
        let reachability = Reachability ()
        if (reachability?.isReachable)! {
            if (reachability?.isReachableViaWiFi)! {
                print("Reachable via WiFi")
                isReachable = true;
            } else {
                isReachable = true;
                print("Reachable via Cellular")
            }
        } else {
            isReachable = false;
            print("Network not reachable")
        }
        return isReachable;
    }
    
    public func initWithRequest(requestUrl:URL,data:(AnyObject)?, methodType:MethodType,headerDictionary:Dictionary<String, String>)-> NetworkHandler{
        url = requestUrl
        bodyData = data
        methodTyeData = methodType.httpMethodForRequest()
        headerDictionaryData = headerDictionary
        return self
    }
    
    // MARK: Inorder to start network service request
    
    /**
     *  Inorder to start network service request
     *
     *  @Return  success block : Success block contains ResponseObject along with status code
     *           failure block : Failure block contains error,statuscode along with errorResponseObject
     */
    
    public func startServieRequest(success: @escaping ( _ responseObject:AnyObject,_ statusCode:NSInteger?) -> Void,failure: @escaping (_ error:Error,_ statusCode:NSInteger,_ errorResponseObject:AnyObject?) -> Void)  {
        if(!networkUnavalible()){
            let errorTemp = NSError(domain:CLNetworkErrorMessage, code:1024, userInfo:nil)
            failure(errorTemp,1024,nil)
            return
        }
        var urlRequest:URLRequest?
        do {
            urlRequest = try URLRequest(url: url, method: methodTyeData, headers: headerDictionaryData)
        }catch {
            print(error)
        }
        if let tempBodyData = bodyData {
            if tempBodyData is String {
                urlRequest?.httpBody = tempBodyData .data(using: String.Encoding.ascii.rawValue, allowLossyConversion: true)
            }else {
                urlRequest?.httpBody = RequestBodyGenerator().requestBodyGeneratorWith(contentDictionary: tempBodyData as AnyObject)
            }
        }
        urlRequest?.timeoutInterval = 40
        urlRequest?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headerDictionaryData
        configuration.httpMaximumConnectionsPerHost = 10;
        let queue = DispatchQueue.global(qos: .`default`)
        Alamofire.request(urlRequest!).validate(statusCode: 200..<600).responseJSON(queue: queue, options: .allowFragments) { (response) in
            switch response.result {
            case .success:
                success(response.result.value as AnyObject,(response.response?.statusCode)!)
                break;
            case.failure(let error):
                print(error)
                failure(error, 0, response.result.value as AnyObject)
                break;
            }
        }
    }
    
    // MARK: Inorder to start String Response network service request
    
    /**
     *  Inorder to start network service request
     *
     *  @Return  success block : Success block contains ResponseObject along with status code
     *           failure block : Failure block contains error,statuscode along with errorResponseObject
     */
    
    public func startStringServieRequest(success: @escaping ( _ responseObject:AnyObject,_ statusCode:NSInteger?) -> Void,failure: @escaping (_ error:Error,_ statusCode:NSInteger,_ errorResponseObject:AnyObject?) -> Void)  {
        if(!networkUnavalible()){
            let errorTemp = NSError(domain:CLNetworkErrorMessage, code:1024, userInfo:nil)
            failure(errorTemp,1024,nil)
            return
        }
        var urlRequest:URLRequest?
        do {
            urlRequest = try URLRequest(url: url, method: methodTyeData, headers: headerDictionaryData)
        }catch {
            print(error)
        }
        if let tempBodyData = bodyData {
            if tempBodyData is String {
                urlRequest?.httpBody = tempBodyData .data(using: String.Encoding.ascii.rawValue, allowLossyConversion: true)
            }else {
                urlRequest?.httpBody = RequestBodyGenerator().requestBodyGeneratorWith(contentDictionary: tempBodyData as AnyObject)
            }
        }
        urlRequest?.timeoutInterval = 40
        urlRequest?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headerDictionaryData
        configuration.httpMaximumConnectionsPerHost = 10;
        let queue = DispatchQueue.global(qos: .`default`)
        Alamofire.request(urlRequest!).validate(statusCode: 200..<600).responseString(queue: queue, encoding: .utf8) { (response) in
            switch response.result {
            case .success:
                success(response.result.value as AnyObject,(response.response?.statusCode)!)
                break;
            case.failure(let error):
                print(error)
                failure(error, 0, response.result.value as AnyObject)
                break;
            }
        }
    }
    
    // MARK: Inorder to start upload service request
    
    /**
     *  Inorder to start upload service request
     *
     *  @param   filename      : File name that we need to save on server
     *           baseUrl       : Base Url
     *           urlPart       : Remaining Urlpart
     *           Data          : Multipart data that we need to upload
     *           fileType      : File type
     *  @Return  success block : Success  block contains ResponseObject along with status code
     *           failure block : Failure  block contains error
     *           progress      : Progress block contains totalProgress value
     */
    
    
    public func startUploadRequest(filename:String,data:Data,fileType:String,
                            success: @escaping ( _ responseObject:AnyObject,_ statusCode:NSInteger) -> Void,
                            progress: @escaping ( _ totalProgress:Double) -> Void,
                            failure: @escaping (_ error:Error) -> Void){
        if(!networkUnavalible()){
           let errorTemp = NSError(domain:CLNetworkErrorMessage, code:1024, userInfo:nil)
            failure(errorTemp)
            return
        }
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headerDictionaryData
        configuration.httpMaximumConnectionsPerHost = 10;
        var urlRequest:URLRequest?
        do {
            urlRequest = try URLRequest(url: url, method: methodTyeData, headers: headerDictionaryData)
        }catch {
            print(error)
        }
        urlRequest?.timeoutInterval = 40
        urlRequest?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName:"file", fileName: filename, mimeType:self.getMimeType(pathExtension: fileType))
            for (key, value) in self.bodyData as! Dictionary<String, Any> as Dictionary {
                if value is String {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName:key)}
                else {
                    multipartFormData.append(value as! Data, withName:key)}
            }
        }, usingThreshold: 10, with: urlRequest!, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (dataProgress) in
                    progress(dataProgress.fractionCompleted);
                })
                upload.responseJSON { response in
                    debugPrint(response)
                    success(response.result.value as AnyObject,(response.response?.statusCode)!)
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
    // MARK: Inorder to start multiple file upload service request
    /**
     *  Inorder to start multiple file upload service request
     *
     *  @param   dataArray     : Data array contains Dictionary of filename with key file_ame and fileData with           key file_data
     *           baseUrl       : Base Url
     *           urlPart       : Remaining Urlpart
     *           fileType      : File type
     *  @Return  success block : Success  block contains ResponseObject along with status code
     *           failure block : Failure  block contains error
     *           progress      : Progress block contains totalProgress value
     */
    
    public func startMultipleFileUploadRequestWith(
                                            dataArray:Array<Any>,
                                            fileType:String,
                                            success: @escaping ( _ responseObject:AnyObject,_ statusCode:NSInteger) -> Void,
                                            progress: @escaping ( _ totalProgress:Double) -> Void,
                                            failure: @escaping (_ error:Error) -> Void) {
        if(!networkUnavalible()){
            let errorTemp = NSError(domain:CLNetworkErrorMessage, code:1024, userInfo:nil)
            failure(errorTemp)
            return
        }
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headerDictionaryData
        configuration.httpMaximumConnectionsPerHost = 10;
        var urlRequest:URLRequest?
        do {
            urlRequest = try URLRequest(url: url, method: methodTyeData, headers: headerDictionaryData)
        }catch {
            print(error)
        }
        urlRequest?.timeoutInterval = 40
        urlRequest?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Alamofire.upload(multipartFormData: { multipartFormData in
            for i in 0 ..< dataArray.count {
                let dataDictionary: Dictionary<String, Any> = dataArray[i] as! Dictionary<String, Any>
                for (key,value) in dataDictionary {
                    multipartFormData.append(value as! Data, withName:"file", fileName: key, mimeType:self.getMimeType(pathExtension: fileType))
                }
            }
            for (key, value) in self.bodyData as! Dictionary<String, Any> as Dictionary {
                if value is String {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName:key)}
                else {
                    multipartFormData.append(value as! Data, withName:key)}
            }
        }, usingThreshold: 10, with: urlRequest!, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (dataProgress) in
                    progress(dataProgress.fractionCompleted);
                })
                upload.responseJSON { response in
                    debugPrint(response)
                    success(response.result.value as AnyObject,(response.response?.statusCode)!)
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
    
    //MARK:  Method Type
    
   public enum MethodType:Int {
        case MethodTypeGET = 1
        case MethodTypePOST
        case MethodTypeDELETE
        case MethodTypePUT
        func httpMethodForRequest()-> Alamofire.HTTPMethod {
            switch  self {
            case .MethodTypeGET:
                return .get
            case .MethodTypePOST :
                return .post
            case .MethodTypeDELETE :
                return .delete
            case .MethodTypePUT:
                return .put
            }
        }
        
        func uploadMethodType()-> String{
            switch  self {
            case .MethodTypeGET:
                return "GET"
            case .MethodTypePOST :
                return "POST"
            case .MethodTypeDELETE :
                return "DELETE"
            case .MethodTypePUT :
                return "PUT"
            }
        }
    }
    
    
    func getMimeType(pathExtension:String) -> String {
        var mimeType:String?
        switch pathExtension {
        case "png":
            mimeType = "image/png"
            break;
        case "jpg":
            mimeType = "image/jpeg"
            break;
        case "jpeg":
            mimeType = "image/jpeg"
            break;
        case "wav":
            mimeType = "audio/wav"
            break;
        case "gif":
            mimeType = "image/gif"
            break;
        case "iff":
            mimeType = "image/iff"
            break;
        case "webp":
            mimeType = "image/iff"
            break;
        case "tiff":
            mimeType = "image/tiff"
            break;
        case "jp2":
            mimeType = "image/jp2"
            break;
        case "mp4":
            mimeType = "video/mp4"
            break;
        default:
            break;
        }
        return mimeType!
    }
}


//MARK: Request Body Generator

public class RequestBodyGenerator: NSObject {
    public static let sharedInstance = RequestBodyGenerator()
    override init() {
        super.init()
    }
    public func requestBodyGeneratorWith (contentDictionary: AnyObject)-> Data {
        var dataString:NSString?
        //let error:NSError
        if(JSONSerialization .isValidJSONObject(contentDictionary)) {
            let sampleData:Data = try! JSONSerialization.data(withJSONObject: contentDictionary, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
            dataString = NSString(data: sampleData as Data, encoding: String.Encoding.utf8.rawValue)
        }
        else {
            dataString = "\(contentDictionary)" as NSString
        }
        //print("requestBodyGeneratorWith :: \(dataString!)")
        return dataString!.data(using: String.Encoding.utf8.rawValue)! as Data
    }
}

//MARK: Request Header Generator

public class RequestHeaderGenerator: NSObject {
    public static let sharedInstance = RequestHeaderGenerator()
    public func urlEncodedHeaderBody() -> [String: String] {
        let headerDictionary:[String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
        return headerDictionary
    }
    
    public func headerBody() ->[String: String] {
        let headerDictionary:[String: String] = ["Content-Type": "application/json"
        ]
        //print("requestBodyGeneratorWith :: \(headerDictionary)")
        return headerDictionary
    }
    
    public func headerBodyWithAccessToken(accessToken:String) -> [String: String] {
        let headerDictionary:[String: String] = ["session-token": accessToken
        ]
        return headerDictionary
    }
    
}

