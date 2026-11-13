//
//  Inmueble.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import Foundation

@Observable
class Estate: Identifiable, Equatable, Hashable {
    let id: UUID
    var name: String
    var address: String
    var habitationalUnits: [HabitationalUnit]?
    
    init(id: UUID = UUID(),
         name: String = "",
         address: String = "",
         habitationalUnits: [HabitationalUnit]? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.habitationalUnits = habitationalUnits
    }
    
    static func == (lhs: borrowing Estate, rhs: borrowing Estate) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
