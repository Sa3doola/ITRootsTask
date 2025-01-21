//
//  UserDefaults.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Foundation

@propertyWrapper
struct ValueDefault<Value> {
    
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return container.value(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct ModelsDefault<Model: Codable> {
    
    let key: String
    let defaultValue: Model
    let container: UserDefaults = .standard
    
    var wrappedValue: Model {
        get {
            let decoder = JSONDecoder()
            guard let decoded = container.object(forKey: key) as? Data else {return defaultValue}
            let loadedValue = try? decoder.decode(Model.self, from: decoded)
            return loadedValue ?? defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                container.set(encoded, forKey: key)
                container.synchronize()
            }
        }
    }
}

extension UserDefaults {
    
    private enum Keys: String {
        case accessToken
        case isLogin
        case user
    }
    
    @ModelsDefault(key: Keys.accessToken.rawValue, defaultValue: "")
    static var accessToken: String?
    
    @ModelsDefault(key: Keys.user.rawValue, defaultValue: nil)
    static var user: UserDTO?
    
    @ValueDefault(key: Keys.isLogin.rawValue, defaultValue: false)
    static var isLogin: Bool 
    
}
