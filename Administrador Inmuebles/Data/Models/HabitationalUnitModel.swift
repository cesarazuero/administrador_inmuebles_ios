//
//  HabitationalUnitModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

import SwiftData
import Foundation

@Model
final class HabitationalUnitModel {
    @Attribute(.unique) var id: UUID
    
    var name: String
    var dueDateEnergyDay: Int = 1
    var dueDateWaterDay: Int = 1
    var dueDateGasDay: Int = 1
    var rentAmount: Double?
    var dateBeginRent: Date = Date()
    @Attribute(.externalStorage) var documentPDF: Data?
    var documentPDFName: String?
    var estateModel: EstateModel?
    
    @Relationship(inverse: \TenantModel.habitationalUnitModel)
    var tenant: TenantModel?
    
    @Relationship(inverse: \DamageModel.habitationalUnitModel)
    var damages: [DamageModel]?
    
    @Relationship(inverse: \PaymentModel.habitationalUnitModel)
    var payments: [PaymentModel]?

    @Relationship(inverse: \MeterCaptureModel.habitationalUnitModel)
    var meterCaptures: [MeterCaptureModel]?

    init(id: UUID = UUID(),
         name: String = "",
         tenant: TenantModel? = nil,
         dueDateEnergyDay: Int = 1,
         dueDateWaterDay: Int = 1,
         dueDateGasDay: Int = 1,
         rentAmount: Double? = nil,
         dateBeginRent: Date = Date(),
         documentPDF: Data? = nil,
         documentPDFName: String? = nil,
         estateModel: EstateModel? = nil,
         damages: [DamageModel]? = nil,
         payments: [PaymentModel]? = nil,
         meterCaptures: [MeterCaptureModel]? = nil) {
        self.id = id
        self.name = name
        self.tenant = tenant
        self.dueDateEnergyDay = dueDateEnergyDay
        self.dueDateWaterDay = dueDateWaterDay
        self.dueDateGasDay = dueDateGasDay
        self.estateModel = estateModel
        self.rentAmount = rentAmount
        self.dateBeginRent = dateBeginRent
        self.documentPDF = documentPDF
        self.documentPDFName = documentPDFName
        self.damages = damages
        self.payments = payments
        self.meterCaptures = meterCaptures
    }
}
