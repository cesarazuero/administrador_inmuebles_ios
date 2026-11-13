//
//  NotificationsModelRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

protocol NotificationsModelRepositoryProtocol {
    func getNotificationModelById(id: String) async -> Notification?
    func enableNotificationById(id: String) async throws
    func disableNotificationById(id: String) async throws
    func createNotification(id: String, title: String, body: String, day: Int, hour: Int, enabled: Bool) async throws
    func getNotificationsModelForService(service: PublicServices) async -> [Notification]?
}
