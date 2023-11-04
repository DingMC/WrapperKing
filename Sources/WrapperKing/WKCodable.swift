//
//  WKCodable.swift
//
//
//  Created by 丁歌 on 2023/11/4.
//

import Foundation

public protocol WKCodable {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
    static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->Value?
}

extension WKCodable{
    public static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->Value?{
        return nil
    }
}

@propertyWrapper
public struct WKDefault<T: WKCodable>: Codable {
    public var wrappedValue: T.Value
    public init() {
        self.wrappedValue = T.defaultValue
    }
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension WKDefault: Equatable where T.Value: Equatable {}
extension WKDefault: Hashable where T.Value: Hashable {}

public extension KeyedDecodingContainer {
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T: WKCodable{
        return try type.handleDefault(self, forKey: key) as? T
    }
    //handle when key missing
    func decode<T>(_ type: WKDefault<T>.Type, forKey key: Key) throws -> WKDefault<T>{
        if let value_t = try? decodeIfPresent(T.self, forKey: key){
            return WKDefault(wrappedValue: value_t as! T.Value)
        }
        if let value = try decodeIfPresent(WKDefault<T>.self, forKey: key) {
            return value
        }
        return WKDefault()
    }
}

public extension KeyedEncodingContainer {
    mutating func encode<T>(_ value: WKDefault<T>, forKey key: Key) throws {
        try encode(value.wrappedValue, forKey: key)
    }
}
