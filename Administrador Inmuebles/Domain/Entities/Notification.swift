//
//  Notifications.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

struct Notification: Sendable {
    var id: String
    var title: String
    var body: String
    var day: Int
    var hour: Int
    var enabled: Bool
    
    init(id: String,
         title: String,
         body: String,
         day: Int,
         hour: Int,
         enabled: Bool) {
        self.id = id
        self.title = title
        self.body = body
        self.day = day
        self.hour = hour
        self.enabled = enabled
    }
}
