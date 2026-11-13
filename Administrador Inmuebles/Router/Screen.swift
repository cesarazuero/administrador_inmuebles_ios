//
//  Screen.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 10/11/26.
//

import Foundation

struct Screen: Hashable {
    let id = UUID()
    let kind: Kind

    enum Kind {
        case createEstate(CreateEstateViewModel)
        case createHabitationalUnit(CreateHabitationalUnitViewModel)
        case createTenant(CreateTenantViewModel)
        case detailEstate(DetailEstateViewModel, MeterCaptureViewModel)
        case detailHabitationalUnit(huId: String, viewModel: DetailHabitationalUnitViewModel, meterCaptureViewModel: MeterCaptureViewModel)
        case settings(SettingsViewModel)
    }

    static func == (lhs: Screen, rhs: Screen) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
