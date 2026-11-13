//
//  NotificationsState.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

struct NotificationsState {
    @UserDefault(wrappedValue: true, key: PublicServices.gas.rawValue)
    static var notificationStateForGas: Bool
    
    @UserDefault(wrappedValue: true, key: PublicServices.energy.rawValue)
    static var notificationStateForEnergy: Bool
    
    @UserDefault(wrappedValue: true, key: PublicServices.water.rawValue)
    static var notificationStateForWater: Bool
    
    static func enableNotificationsFor(service: PublicServices) {
        switch service {
        case .energy:
            notificationStateForEnergy =  true
        case .water:
            notificationStateForWater = true
        case .gas:
            notificationStateForGas = true
        }
    }
    
    static func disableNotificationsFor(service: PublicServices) {
        switch service {
        case .energy:
            notificationStateForEnergy =  false
        case .water:
            notificationStateForWater = false
        case .gas:
            notificationStateForGas = false
        }
    }
}
