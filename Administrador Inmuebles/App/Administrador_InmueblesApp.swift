//
//  Administrador_InmueblesApp.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import SwiftUI
import SwiftData

@main
struct Administrador_InmueblesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("AppBackground").ignoresSafeArea())
                .preferredColorScheme(.dark)
                .modelContainer(DependencyContainer.shared.getModelContainer())
                .onAppear {
                    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                        print("📋 Total de notificaciones pendientes: \(requests.count)")
                        for request in requests {                            
                            print("---")
                            print("ID: \(request.identifier)")
                            print("Contenido: \(request.content.title) - \(request.content.body)")
                            print("Disparador (Trigger): \(request.debugDescription)")
                        }
                    }
                }
        }
    }
}
