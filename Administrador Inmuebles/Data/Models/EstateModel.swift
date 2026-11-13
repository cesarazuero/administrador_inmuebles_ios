//
//  EstateModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

import SwiftData
import Foundation

@Model
final class EstateModel {
    @Attribute(.unique) var id: UUID
    
    var name: String
    var address: String
    
    @Relationship(inverse: \HabitationalUnitModel.estateModel)
    var habitationalUnits: [HabitationalUnitModel]?
    
    init(id: UUID = UUID(),
         name: String = "",
         address: String = "",
         habitationalUnits: [HabitationalUnitModel]? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.habitationalUnits = habitationalUnits
    }
}
