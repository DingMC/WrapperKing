//
//  WKCodableDate.swift
//
//
//  Created by 丁歌 on 2023/11/4.
//

import Foundation


public protocol WKCodableDate {
    static var defaultValue: Date? { get }
    static var dateFormatter: DateFormatter {get}
}

@propertyWrapper
public struct WKDefaultDate<T: WKCodableDate>: Codable {
    public var wrappedValue: Date?
    public init() {
        self.wrappedValue = T.defaultValue
    }
    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let v = try? container.decode(String.self){
            if let date = T.dateFormatter.date(from: v){
                self.wrappedValue = date
                return
            }
        }
        self.wrappedValue = (try? container.decode(Date.self)) ?? T.defaultValue
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<T>(_ value: WKDefaultDate<T>, forKey key: Key) throws {
        if let d = value.wrappedValue{
            try encode(T.dateFormatter.string(from: d), forKey: key)
            return
        }
    }
}

public struct UTCDate: WKCodableDate{
    public static var defaultValue: Date?
    public static var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hans_CN")
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }
}

public struct YMDHMSDate: WKCodableDate{
    public static var defaultValue: Date?
    public static var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hans_CN")
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
}
