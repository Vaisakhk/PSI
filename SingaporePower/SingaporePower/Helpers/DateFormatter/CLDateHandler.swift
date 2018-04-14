//
//  CLDateHandler.swift
//  SingaporePower
//
//  Created by User on 4/14/18.
//  Copyright © 2018 VK. All rights reserved.
//

import UIKit

public class CLDateHandler: NSObject {
    
    public static let sharedHandlerInsatnce = CLDateHandler()
    let dateFormatter:DateFormatter = DateFormatter ()
    
    /**
     *  Convert NSDate to string format
     *
     *  @param currentDate : date that we need to convert
     *       formatedString: string format that we need to convert current date (EX: YYYY-mm-dd hh:MM:ss sss)
     *
     *  @return            : Converted String
     *
     */
    
    public func convertDateToFormatedString(currentDate:Date,formatedString:String,timezone:TimeZone) ->String {
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = formatedString
        return dateFormatter.string(from: currentDate)
    }
    
    /**
     *  To get time stamp from date
     *
     *  @param date : date that we need to convert
     *
     *  @return     : Time stamp
     *
     */

    
    public func createTimeStampFor(date:Date) -> NSNumber {
        return NSNumber(value: date.timeIntervalSince1970)
    }
    
    /**
     *  Convert string to NSDate format
     *
     *  @param dateString  : String that we need to convert
     *       formatedString: string format that we need to convert current date (EX: YYYY-mm-dd hh:MM:ss sss)
     *              timezon: Date Time zone
     *  @return            : Converted Date
     *
     */

    
    public func convertToDateCorespondingTo(dateString:String,formatedString:String,timezone:TimeZone) -> Date? {
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = formatedString
        return dateFormatter.date(from: dateString)
    }
    
    /**
     *  Compare two dates
     *
     *  @param fromDateTime : first Date
     *            toDateTime: Second Date
     *
     *  @return            : NSDateComponents object that gives all information about date difference
     *
     */
    
    public func compareDates(fromDateTime:Date,toDateTime:Date) -> DateComponents {
        let calendar = Calendar.current
        return  calendar.dateComponents([.day,.month,.year,.hour,.minute,.second,.weekday,.weekdayOrdinal], from: fromDateTime, to: toDateTime)
    }
    
    public func getCurrentDay(date:Date)-> Int{
        var components = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: date)
        components.timeZone = TimeZone(abbreviation: "GMT+8")
       return components.weekday!
    }
    
    public func getCurrentTimeInSeconds(date:Date)-> Int{
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: date)
        return components.weekday!
    }
}
