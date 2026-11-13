//
//  TenantModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//
import SwiftData
import Foundation

@Model
final class TenantModel {
    @Attribute(.unique) var id: UUID
    
    var name: String
    var identification: String
    var identification_type: String
    var phoneNumber: Int?
    var email: String
    var habitationalUnitModel: HabitationalUnitModel?
    
    init(id: UUID = UUID(),
         name: String = "",
         identification: String = "",
         identification_type: String = "CC",
         phoneNumber: Int? = nil,
         email: String = "",
         habitationalUnitModel: HabitationalUnitModel? = nil) {
        self.id = id
        self.name = name
        self.identification = identification
        self.identification_type = identification_type
        self.phoneNumber = phoneNumber
        self.email = email
        self.habitationalUnitModel = habitationalUnitModel
    }
}
