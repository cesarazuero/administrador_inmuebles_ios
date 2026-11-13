//
//  UnidadHabitacional.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import Foundation
import SwiftData

@Observable
class HabitationalUnit: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var tenant: Tenant?
    var dueDateEnergyDay: Int
    var dueDateWaterDay: Int
    var dueDateGasDay: Int
    var rentAmount: Double?
    var dateBeginRent: Date
    var documentPDF: Data?
    var documentPDFName: String?
    var damages: [Damage]?
    var payments: [Payment]?
    var meterCaptures: [MeterCapture]?

    init(id: UUID = UUID(),
         name: String = "",
         tenant: Tenant? = nil,
         dueDateEnergyDay: Int = 1,
         dueDateWaterDay: Int = 1,
         dueDateGasDay: Int = 1,
         rentAmount: Double? = nil,
         dateBeginRent: Date = Date(),
         documentPDF: Data? = nil,
         documentPDFName: String? = nil,
         damages: [Damage]? = [],
         payments: [Payment]? = [],
         meterCaptures: [MeterCapture]? = []) {
        self.id = id
        self.name = name
        self.tenant = tenant
        self.dueDateEnergyDay = dueDateEnergyDay
        self.dueDateWaterDay = dueDateWaterDay
        self.dueDateGasDay = dueDateGasDay
        self.rentAmount = rentAmount
        self.dateBeginRent = dateBeginRent
        self.documentPDF = documentPDF
        self.documentPDFName = documentPDFName
        self.damages = damages
        self.payments = payments
        self.meterCaptures = meterCaptures
    }
    
    static func == (lhs: borrowing HabitationalUnit, rhs: borrowing HabitationalUnit) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
