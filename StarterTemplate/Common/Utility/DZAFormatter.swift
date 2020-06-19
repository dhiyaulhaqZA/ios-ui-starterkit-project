//
//  DZAFormatter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

enum DateFormatType {
    case short, medium, long
    
    var format: String {
        switch self {
        case .short:
            return "dd MMM"
        case .medium:
            return "dd MMM yyyy"
        case .long:
            return "dd MMM yyyy, HH.mm"
        }
    }
}

class DZAFormatter {
    static func formatPrice(_ price: Double?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        let formattedNumber = numberFormatter.string(from: NSNumber(value: price ?? 0.0))
        return "Rp\(formattedNumber ?? "")"
    }
    
    static func formatDate(_ unformattedDate: String, formatType: DateFormatType) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatterGet.date(from: unformattedDate)
        if let date = date {
            dateFormatterGet.locale = Locale(identifier: "id_ID")
            dateFormatterGet.dateFormat = formatType.format
            dateFormatterGet.timeZone = TimeZone.current
            return dateFormatterGet.string(from: date)
        }
        let index = unformattedDate.index(unformattedDate.startIndex, offsetBy: 10)
        return "\(unformattedDate[..<index])"
    }
    
    static func getDateOf(_ unformattedDate: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatterGet.date(from: unformattedDate)
    }
    
    static func getDateMilliSecond(date: Date) -> Int64 {
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    static func getDateMilliSecond(_ unformattedDate: String) -> Int64 {
        return Int64((getDateOf(unformattedDate)?.timeIntervalSince1970 ?? 0) * 1000)
    }
    
    static func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: date)
    }
    
    static func formatPhone(phone: String, isBypass: Bool = false) -> String {
        var phoneNumber = phone
        if isBypass {
            if phone.hasPrefix("08") {
                phoneNumber = phone.replacingCharacters(in: ...phone.startIndex, with: "621162")
            } else if phone.hasPrefix("+628") {
                phoneNumber = phone.replacingOccurrences(of: "+628", with: "6211628")
            } else if phone.hasPrefix("+621162") {
                phoneNumber = phone.replacingOccurrences(of: "+621162", with: "621162")
            } else if phone.hasPrefix("628") {
                let end = phone.index(phone.startIndex, offsetBy: 3)
                phoneNumber = phone.replacingCharacters(in: ..<end, with: "6211628")
            }
        } else {
            if phone.hasPrefix("0") {
                phoneNumber = phone.replacingCharacters(in: ...phone.startIndex, with: "62")
            } else if phone.hasPrefix("+") {
                phoneNumber = phone.replacingOccurrences(of: "+", with: "")
            }
        }
        return phoneNumber
    }
}
