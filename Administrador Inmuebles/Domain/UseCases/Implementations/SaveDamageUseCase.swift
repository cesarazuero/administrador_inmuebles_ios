//
//  SaveDamageUseCase.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 26/10/26.
//
import SwiftData

struct SaveDamageUseCase: SaveDamageUseCaseProtocol {
    private let modelContext: ModelContext
    private let habitationalUnitRepository: HabitationalUnitRepositoryProtocol
    
    init(modelContext: ModelContext,
         habitationalUnitRepository: HabitationalUnitRepositoryProtocol) {
        self.modelContext = modelContext
        self.habitationalUnitRepository = habitationalUnitRepository
    }
    
    func execute(damage: Damage, habitationalUnitId: String) throws {
        guard let hu = habitationalUnitRepository.getHabitationalUnitById(id: habitationalUnitId) else { return }
        
        if hu.damages == nil {
            hu.damages = []
        }
        
        hu.damages?.append(damage)
        
        try habitationalUnitRepository.saveDamage(huId: habitationalUnitId, damage: damage)
    }
}
