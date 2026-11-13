//
//  Damage.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//

internal import Combine
import SwiftData
import Foundation

@Observable
class Damage: Identifiable, Equatable, Hashable {
    let id: UUID
    var damage: String
    var created_at: Date
    var state: DamageState
    var issuer: String?
    var photoPaths: [String]?
    
    init(id: UUID = UUID(),
         damage: String,
         created_at: Date,
         state: DamageState,
         issuer: String?,
         photoPaths: [String]?) {
        self.id = id
        self.damage = damage
        self.created_at = created_at
        self.state = state
        self.issuer = issuer
        self.photoPaths = photoPaths
    }
    
    static func == (lhs: borrowing Damage, rhs: borrowing Damage) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
