//
//  PersistenceService.swift
//  Farelki
//
//  Created by роман поздняков on 07/04/2019.
//  Copyright © 2019 romchick. All rights reserved.
//

import Foundation

final class PersistanceService {
    
    // MARK: - Keys
    private static let firstEntryKey = "firstEntry"
    private static let nameKey = "Name"
    private static let photoKey = "photo"
    private static let ZakazTextKey = "ZakazText"
    private static let priceKey = "price"
    
    // MARK: - Properties
    static var firstEntry: Bool {
        get {
            return UserDefaults.standard.bool(forKey: firstEntryKey)
        }
        set {
            UserDefaults.standard.setValue(newValue,
                                           forKey: firstEntryKey)
        }
    }
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: nameKey)
        }
    }
    
    static var photo: String {
        get {
            return UserDefaults.standard.string(forKey: photoKey) ?? "placeholder-user"
        }
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: photoKey)
        }
    }
    
    static var zakazText: String {
        get {
            return UserDefaults.standard.string(forKey: ZakazTextKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: ZakazTextKey)
        }
    }
    
    static var price: Int {
        get {
            return UserDefaults.standard.integer(forKey: priceKey)
        }
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: priceKey)
        }
    }
}
