//
//  WKCodableExtension.swift
//
//
//  Created by 丁歌 on 2023/11/4.
//

import Foundation

public enum EmptyCollection<A>: WKCodable where A: Codable & Equatable & RangeReplaceableCollection {
    public static var defaultValue: A { A() }
}

public enum EmptyArray<A>: WKCodable where A: Codable {
    public static var defaultValue: A { Array<A>() as! A }
}

public enum EmptyDictionary<K, V>: WKCodable where K: Hashable & Codable, V: Equatable & Codable {
    public static var defaultValue: [K: V] { Dictionary() }
}

public enum False: WKCodable {
    public static let defaultValue = false
}

public enum True: WKCodable {
    public static let defaultValue = true
}

extension Bool: WKCodable{
    public static var defaultValue: Bool = false
}

extension Int: WKCodable{
    public static var defaultValue: Int = 0
    public static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->Int?{
        let isNil = try container.decodeNil(forKey: key)
        if !isNil{
            if let v = try? container.decode(Int.self, forKey: key){
                return v
            }
            if let v = try? container.decode(String.self, forKey: key){
                return Int(v)
            }
            if let v = try? container.decode(Bool.self, forKey: key){
                return v ? 1 : 0
            }
        }
        return nil
    }
}

extension String: WKCodable{
    public static var defaultValue: String = ""
    public static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->String?{
        let isNil = try container.decodeNil(forKey: key)
        if !isNil{
            if let v = try? container.decode(String.self, forKey: key){
                return v
            }
            if let v = try? container.decode(Int.self, forKey: key){
                return String(v)
            }
        }
        return nil
    }
}

extension Double: WKCodable{
    public static var defaultValue: Double = 0.0
    public static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->Double?{
        let isNil = try container.decodeNil(forKey: key)
        if !isNil{
            if let v = try? container.decode(Double.self, forKey: key){
                return v
            }
            if let v = try? container.decode(Int.self, forKey: key){
                return Double(v)
            }
            if let v = try? container.decode(Float.self, forKey: key){
                return Double(v)
            }
        }
        return nil
    }
}

extension Float: WKCodable{
    public static var defaultValue: Float = 0.0
    public static func handleDefault<Key>(_ container: KeyedDecodingContainer<Key>, forKey key: Key)throws->Float?{
        let isNil = try container.decodeNil(forKey: key)
        if !isNil{
            if let v = try? container.decode(Float.self, forKey: key){
                return v
            }
            if let v = try? container.decode(Int.self, forKey: key){
                return Float(v)
            }
            if let v = try? container.decode(Double.self, forKey: key){
                return Float(v)
            }
        }
        return nil
    }
}
