//
//  LocalState.swift
//  Bankey
//
//  Created by simonecaria on 04/02/25.
//

import Foundation

public class LocalState {
    private enum Keys : String {
        case hasOnBoarded
    }
    
    public static var hasOnBoarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnBoarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnBoarded.rawValue)
        }
    }
}
