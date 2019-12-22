//
//  Utils.swift
//  CSVParser
//
//  Created by Jaime Terra on 22/12/19.
//  Copyright © 2019 Jaime Terra. All rights reserved.
//

import Foundation
class Utils {
    static func readDataFromCSV(fileName:String)-> String!{
        if(fileName != ""){
            guard let path = Bundle.main.path(forResource: fileName, ofType: "csv")
                else {
                    return nil
            }
            do {
                return try String(contentsOfFile: path, encoding: .utf8)
            } catch {
                print("Error reading file on path: \(path)")
                return nil
            }
        } else {
            return ""
        }
    }

    static func tryToConvertDateToPattern(dateString: String)-> String! {
        // Swift
        let dateString = dateString // the date string to be parsed
        print(dateString)
        let df1 = DateFormatter()
        df1.locale = Locale(identifier: "en_US")
        df1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = df1.date(from: dateString) {
            print(date)
            let df2 = DateFormatter()
            df2.dateStyle = .long
            df2.timeStyle = .none
            let string = df2.string(from: date)
            print(string)
            return string
        } else {
            print("Unable to parse date string")
            return dateString
        }
    }
    
    static func removeCSVUnnecessaryCharacters(string: String)-> String {
        return string.replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\"", with: "")
    }
}
