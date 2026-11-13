//
//  NotificationsUseCase.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

import UserNotifications
import SwiftData

struct NotificationsUseCase: NotificationsUseCaseProtocol {
    let notificationsRepository: NotificationsModelRepositoryProtocol
    
    init(notificationsRepository: NotificationsModelRepositoryProtocol) {
        self.notificationsRepository = notificationsRepository
    }
    
    func scheduleMonthlyNotification(day: Int,
                                     title: String,
                                     body: String,
                                     notificationId: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let hour = 9
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        let identifier = notificationId
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error al programar la notificación: \(error)")
            } else {
                Task {
                    do {
                        try await notificationsRepository.createNotification(id: notificationId,
                                                                             title: title,
                                                                             body: body,
                                                                             day: day,
                                                                             hour: hour,
                                                                             enabled: true)
                        print("✅ Notificación programada con éxito para el día \(day) de cada mes a las 09:00 AM.")
                    } catch let error {
                        print("❌ Se ha producido un error al guardar la Notificaction en la DB: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func disableNotification(publicService: PublicServices) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let requestIdsToDelete = requests.filter { $0.identifier.contains(publicService.rawValue) }.map { $0.identifier }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestIdsToDelete)
            NotificationsState.disableNotificationsFor(service: publicService)
            
            Task {
                do {
                    for id in requestIdsToDelete {
                        try await notificationsRepository.disableNotificationById(id: id)
                    }
                } catch let error {
                    print("❌ Se ha producido un error al deshabilitar la Notificaction en la DB: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func enableNotification(publicService: PublicServices) {
        NotificationsState.enableNotificationsFor(service: publicService)
        
        Task {
            do {
                if let notificationsExistent = await notificationsRepository.getNotificationsModelForService(service: publicService) {
                    for notification in notificationsExistent {
                        scheduleMonthlyNotification(day: notification.day,
                                                    title: notification.title,
                                                    body: notification.body,
                                                    notificationId: notification.id)
                        try await notificationsRepository.enableNotificationById(id: notification.id)
                    }
                }
            } catch {
                print("❌ Se ha producido un error al habilitar la Notificaction en la DB: \(error.localizedDescription)")
            }
        }
    }
    
    func getNotificationIdentifier(publicService: PublicServices, huId: String) -> String {
        return "\(huId):\(publicService.rawValue)"
    }
}
