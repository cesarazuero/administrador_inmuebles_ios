//
//  NotificationsRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

import SwiftData
import Foundation

@ModelActor
actor NotificationsRepository: NotificationsModelRepositoryProtocol {
    func getNotificationModelById(id: String) async -> Notification? {
        var fetchDescriptor = FetchDescriptor<NotificationsModel>(predicate: #Predicate { $0.id == id })
            fetchDescriptor.fetchLimit = 1
        
        do {
            if let result = try modelContext.fetch(fetchDescriptor).first {
                return await Notification(id: result.id,
                                          title: result.title,
                                          body: result.body,
                                          day: result.day,
                                          hour: result.hour,
                                          enabled: result.enabled)
            } else {
                return nil
            }
        } catch let error {
            print("Error in query for NotificationsModel by Id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getNotificationsModelForService(service: PublicServices) async -> [Notification]? {
        let serviceRawValue = service.rawValue
        let fetchDescriptor = FetchDescriptor<NotificationsModel>(predicate: #Predicate { $0.id.contains(serviceRawValue) })
        
        do {
            let results = try modelContext.fetch(fetchDescriptor)
            var array: [Notification] = []
            
            for result in results {
                let item = await Notification(id: result.id,
                                              title: result.title,
                                              body: result.body,
                                              day: result.day,
                                              hour: result.hour,
                                              enabled: result.enabled)
                
                array.append(item)
            }
            
            return array
        } catch let error {
            print("Error in query for NotificationsModel by Id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func enableNotificationById(id: String) async throws {
        var fetchDescriptor = FetchDescriptor<NotificationsModel>(predicate: #Predicate { $0.id == id })
            fetchDescriptor.fetchLimit = 1
        
        guard let model = try? modelContext.fetch(fetchDescriptor).first else { return }
        
        model.enabled = true
        
        try modelContext.save()
    }
    
    func disableNotificationById(id: String) async throws {
        var fetchDescriptor = FetchDescriptor<NotificationsModel>(predicate: #Predicate { $0.id == id })
            fetchDescriptor.fetchLimit = 1
        
        guard let model = try? modelContext.fetch(fetchDescriptor).first else { return }
        
        model.enabled = false
        
        try modelContext.save()
    }
    
    func createNotification(id: String, title: String, body: String, day: Int, hour: Int, enabled: Bool) async throws {
        var fetchDescriptor = FetchDescriptor<NotificationsModel>(predicate: #Predicate { $0.id == id })
            fetchDescriptor.fetchLimit = 1
        
        if let modelExistent = try? modelContext.fetch(fetchDescriptor).first {
            modelExistent.id = id
            modelExistent.title = title
            modelExistent.body = body
            modelExistent.day = day
            modelExistent.hour = hour
            modelExistent.enabled = enabled
        } else {
            let model = NotificationsModel(id: id,
                                       title: title,
                                       body: body,
                                       day: day,
                                       hour: hour,
                                       enabled: true)
            
            modelContext.insert(model)
        }
        
        try modelContext.save()
    }
}
