//
//  PaymentModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//

import SwiftData
import Foundation

@Model
final class PaymentModel {
    @Attribute(.unique) var id: UUID
    
    var created_at: Date
    var payment_date: Date
    var amount: Double
    var made_by: String?
    var bank: String
    var habitationalUnitModel: HabitationalUnitModel?
    
    init(id: UUID = UUID(),
         created_at: Date,
         payment_date: Date,
         amount: Double,
         made_by: String?,
         bank: String,
         habitationalUnitModel: HabitationalUnitModel? = nil) {
        self.id = id
        self.created_at = created_at
        self.payment_date = payment_date
        self.amount = amount
        self.made_by = made_by
        self.bank = bank
        self.habitationalUnitModel = habitationalUnitModel
    }
}
