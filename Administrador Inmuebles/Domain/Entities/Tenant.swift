//
//  Tenant.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 9/10/26.
//

internal import Combine
import SwiftData
import Foundation

@Observable
class Tenant: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var identification: String
    var identification_type: String
    var phoneNumber: Int?
    var email: String
    
    init(id: UUID = UUID(),
         name: String = "",
         identification: String = "",
         identification_type: String = "CC",
         phoneNumber: Int? = nil,
         email: String = "") {
        self.id = id
        self.name = name
        self.identification = identification
        self.identification_type = identification_type
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    static func == (lhs: borrowing Tenant, rhs: borrowing Tenant) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
