//
//  SavePaymentUseCase.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 30/10/26.
//
import SwiftData

struct SavePaymentUseCase: SavePaymentUseCaseProtocol {
    private let modelContext: ModelContext
    private let habitationalUnitRepository: HabitationalUnitRepositoryProtocol
    
    init(modelContext: ModelContext,
         habitationalUnitRepository: HabitationalUnitRepositoryProtocol) {
        self.modelContext = modelContext
        self.habitationalUnitRepository = habitationalUnitRepository
    }
    
    func execute(payment: Payment, habitationalUnitId: String) throws {
        guard let hu = habitationalUnitRepository.getHabitationalUnitById(id: habitationalUnitId) else { return }
        
        if hu.payments == nil {
            hu.payments = []
        }
        
        hu.payments?.append(payment)
        
        try habitationalUnitRepository.savePayment(huId: habitationalUnitId, payment: payment)
    }
    
    
}
