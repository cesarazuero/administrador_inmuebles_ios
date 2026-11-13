//
//  SettingsViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//
import SwiftUI

@Observable
class SettingsViewModel {
    var notificationsGas: Bool
    var notificationsEnergy: Bool
    var notificationsWater: Bool
    
    private let notificationsUseCase: NotificationsUseCase
    
    init(notificationsUseCase: NotificationsUseCase) {
        notificationsGas = NotificationsState.notificationStateForGas
        notificationsWater = NotificationsState.notificationStateForWater
        notificationsEnergy = NotificationsState.notificationStateForEnergy
        
        self.notificationsUseCase = notificationsUseCase
    }
    
    func disableNotificationsFor(service: PublicServices) {
        notificationsUseCase.disableNotification(publicService: service)
    }
    
    func enableNotificationsFor(service: PublicServices) {
        notificationsUseCase.enableNotification(publicService: service)
    }
}
