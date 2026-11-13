//
//  Permissions.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 5/11/26.
//

import UserNotifications

struct Permissions {
    nonisolated static func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                completion(true)
            } else if let error = error {
                print("Error al pedir permisos: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
