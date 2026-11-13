//
//  CreateEstateViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 7/10/26.
//

import SwiftUI
import SwiftData
internal import Combine

@Observable
final class CreateEstateViewModel {
    var estate: Estate
    var showAlert: Bool = false
    private(set) var messageAlert: String = ""
    private(set) var titleAlert: String = ""
    private(set) var btnDoneRole: ButtonRole? = nil
    private let saveEstateUseCase: SaveEstateUseCaseProtocol
    private let router: Router
    private let id: String?
    private let estateRepository: EstateRepositoryProtocol
    private let notificationsUseCase: NotificationsUseCase
    
    init(estate: Estate,
         id: String?,
         saveEstateUseCase: SaveEstateUseCaseProtocol,
         estateRepository: EstateRepositoryProtocol,
         router: Router,
         notificationsUseCase: NotificationsUseCase) {
        self.estate = estate
        self.saveEstateUseCase = saveEstateUseCase
        self.router = router
        self.id = id
        self.estateRepository = estateRepository
        self.notificationsUseCase = notificationsUseCase
        
        if id != nil { checkFormStatus() }
    }
    
    private func getHabitationalUnitModel(id: String?) -> HabitationalUnit {
        if let id = id {
            return getExistentHU(id: id) ?? HabitationalUnit()
        } else {
            return HabitationalUnit()
        }
    }
    
    private func getExistentHU(id: String) -> HabitationalUnit? {
        return estate.habitationalUnits?.first(where: { $0.id.uuidString == id })
    }
    
    func saveEstate() -> Bool {
        if estate.address.isEmpty || estate.name.isEmpty {
            titleAlert = String(localized: "data_missing_title")
            messageAlert = String(localized: "data_missing_message")
            showAlert = true
            
            return false
        }
        
        do {
            try saveEstateUseCase.execute(estate: estate)
            
            Permissions.requestNotificationPermission { [weak self] granted in
                guard let self = self, granted else { return }
                
                let title = String(localized: "estate_manager")
                
                if let hus = self.estate.habitationalUnits {
                    for hu in hus {
                        notificationsUseCase.scheduleMonthlyNotification(day: hu.dueDateEnergyDay,
                                                                         title: title,
                                                                         body: String(localized: "due_date_energy_is_today"),
                                                                         notificationId: notificationsUseCase.getNotificationIdentifier(publicService: .energy,
                                                                                                                                        huId: hu.id.uuidString))
                        
                        notificationsUseCase.scheduleMonthlyNotification(day: hu.dueDateWaterDay,
                                                                         title: title,
                                                                         body: String(localized: "due_date_water_is_today"),
                                                                         notificationId: notificationsUseCase.getNotificationIdentifier(publicService: .water,
                                                                                                                                        huId: hu.id.uuidString))
                        
                        notificationsUseCase.scheduleMonthlyNotification(day: hu.dueDateGasDay,
                                                                         title: title,
                                                                         body: String(localized: "due_date_gas_is_today"),
                                                                         notificationId: notificationsUseCase.getNotificationIdentifier(publicService: .gas,
                                                                                                                                        huId: hu.id.uuidString))
                    }
                }
            }
            
            return true
        } catch {
            titleAlert = String(localized: "error")
            messageAlert = "\(String(localized: "error_saving_estate"))\n\(String(localized: "please_try_again"))"
            showAlert = true
            
            return false
        }
    }
    
    func checkFormStatus() {
        let condition = !estate.name.isEmpty && !estate.address.isEmpty && estate.habitationalUnits != nil
        btnDoneRole = condition || id != nil ? .confirm : nil
    }
    
    func goToCreateHabitationalUnit(id: String?) {        
        router.navigateTo(route: Destination.createHabitationalUnit(id: id))
    }
    
    func goBack() {
        clearEstate()
        router.goBack()
    }
    
    private func clearEstate() {
        estate.name = ""
        estate.address = ""
        estate.habitationalUnits = nil
    }
    
    
}
