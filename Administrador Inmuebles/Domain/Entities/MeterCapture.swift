//
//  MeterCapture.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

import Foundation
import Observation

@Observable
class MeterCapture: Identifiable, Equatable, Hashable {
    let id: UUID
    var type: PublicServices
    var measure: Double
    var date: Date

    init(id: UUID = UUID(),
         type: PublicServices,
         measure: Double,
         date: Date) {
        self.id = id
        self.type = type
        self.measure = measure
        self.date = date
    }

    static func == (lhs: borrowing MeterCapture, rhs: borrowing MeterCapture) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
