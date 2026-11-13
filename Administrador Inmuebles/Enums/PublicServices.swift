//
//  PublicServices.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 5/11/26.
//
import Foundation

enum PublicServices: String, Codable, CaseIterable {
    case water = "Water"
    case energy = "Energy"
    case gas = "Gas"
    
    var localized: String {
        switch self {
        case .water:
            return String(localized: "water")
        case .energy:
            return String(localized: "energy")
        case .gas:
            return String(localized: "gas")
        }
    }
    
    var icon: String {
        switch self {
        case .water:
            return String(localized: "drop")
        case .energy:
            return String(localized: "bolt")
        case .gas:
            return String(localized: "flame")
        }
    }
}
