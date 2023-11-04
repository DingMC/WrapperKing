//
//  WKUserDefaults.swift
//
//
//  Created by 丁歌 on 2023/11/4.
//

import Foundation

@propertyWrapper
public struct WKUserDefaults<T>{
    let key: String
    let defaultValue: T?
    
    public init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T? {
        get{
            return UserDefaults.standard.object(forKey: key) as? T
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
