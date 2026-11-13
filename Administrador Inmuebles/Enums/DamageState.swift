//
//  DamageState.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//
import SwiftUI

enum DamageState: String, Codable, CaseIterable {
    case created
    case inProgress
    case waitingResponse
    case fixed
    
    func getColor() -> Color {
        switch self {
        case .created:
                .white
        case .inProgress:
                .orange
        case .waitingResponse:
                .yellow
        case .fixed:
                .green
        }
    }
    
    var localizedName: String {
        switch self {
        case .created:
            return String(localized: "damage_state_created", comment: "Estado creado")
        case .inProgress:
            return String(localized: "damage_state_in_progress", comment: "Estado en progreso")
        case .waitingResponse:
            return String(localized: "damage_state_waiting_response", comment: "Estado esperando respuesta")
        case .fixed:
            return String(localized: "damage_state_fixed", comment: "Estado solucionado")
        }
    }
}
