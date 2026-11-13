//
//  UserDefaults.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let container: UserDefaults
    
    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
    
    init(wrappedValue: T, key: String, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.container = container
    }
}
