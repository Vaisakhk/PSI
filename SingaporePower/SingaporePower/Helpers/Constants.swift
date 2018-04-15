import UIKit

struct Constants {
    static let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    struct AlertMessage {
        //Common
        static let errorNetworkFailed = "Unable to connect to the server. Check your connection, then try again."
        static let noDataAvailable = "Data not available"
    }
    
    struct Api {
        static let BASEURL = "https://api.data.gov.sg/v1/environment/psi?";
    }
}
