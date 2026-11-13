//
//  DamageModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//

import SwiftData
import Foundation

@Model
final class DamageModel {
    @Attribute(.unique) var id: UUID
    
    var damage: String
    var created_at: Date
    var state: DamageState
    var issuer: String?
    var photoPaths: [String]?
    var habitationalUnitModel: HabitationalUnitModel?
    
    init(id: UUID = UUID(),
         damage: String,
         created_at: Date,
         state: DamageState,
         issuer: String?,
         photoPaths: [String]?,
         habitationalUnitModel: HabitationalUnitModel? = nil) {
        self.id = id
        self.damage = damage
        self.created_at = created_at
        self.state = state
        self.issuer = issuer
        self.photoPaths = photoPaths
        self.habitationalUnitModel = habitationalUnitModel
    }
}
