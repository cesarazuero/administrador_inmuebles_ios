//
//  Destination.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 8/10/26.
//
import SwiftUI

enum Destination: Hashable {
    case createEstate(id: String?)
    case createHabitationalUnit(id: String?)
    case createTenant(huId: String?)
    case detailEstate(estate: Estate)
    case detailHabitationalUnit(huId: String)
    case settings
}
