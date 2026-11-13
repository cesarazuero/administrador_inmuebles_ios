//
//  NotificationsUseCaseProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

protocol NotificationsUseCaseProtocol {
    func scheduleMonthlyNotification(day: Int,
                                     title: String,
                                     body: String,
                                     notificationId: String)
    func getNotificationIdentifier(publicService: PublicServices,
                                   huId: String) -> String
    func disableNotification(publicService: PublicServices)
    func enableNotification(publicService: PublicServices)
}
