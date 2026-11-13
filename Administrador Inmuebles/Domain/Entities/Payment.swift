//
//  Payment.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//

internal import Combine
import SwiftData
import Foundation

@Observable
class Payment: Identifiable, Equatable, Hashable {
    let id: UUID
    var created_at: Date
    var payment_date: Date
    var amount: Double
    var made_by: String?
    var bank: String
    
    init(id: UUID = UUID(),
         created_at: Date,
         payment_date: Date,
         amount: Double,
         made_by: String?,
         bank: String) {
        self.id = id
        self.created_at = created_at
        self.payment_date = payment_date
        self.amount = amount
        self.made_by = made_by
        self.bank = bank
    }
    
    static func == (lhs: borrowing Payment, rhs: borrowing Payment) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
