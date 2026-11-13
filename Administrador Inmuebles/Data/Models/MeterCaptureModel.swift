//
//  MeterCaptureModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

import SwiftData
import Foundation

@Model
final class MeterCaptureModel {
    @Attribute(.unique) var id: UUID

    var type: PublicServices
    var measure: Double
    var date: Date
    var habitationalUnitModel: HabitationalUnitModel?

    init(id: UUID = UUID(),
         type: PublicServices,
         measure: Double,
         date: Date,
         habitationalUnitModel: HabitationalUnitModel? = nil) {
        self.id = id
        self.type = type
        self.measure = measure
        self.date = date
        self.habitationalUnitModel = habitationalUnitModel
    }
}
