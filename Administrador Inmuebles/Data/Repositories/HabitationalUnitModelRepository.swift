//
//  HabitationalUnitRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//
import SwiftData
import Foundation

struct HabitationalUnitModelRepository: HabitationalUnitRepositoryProtocol {
    private let modelContainer: ModelContainer
    
    init(_ modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func getAllHabitationalUnits() -> [HabitationalUnit]? {
        let fetchDescriptor = FetchDescriptor<HabitationalUnitModel>(sortBy: [SortDescriptor(\.name, order: .forward)])
        
        do {
            let results = try modelContainer.mainContext.fetch(fetchDescriptor)
            let hus = results.map {
                HabitationalUnitMapper.toDomain(hu: $0)
            }
            
            return hus
        } catch {
            return nil
        }
    }
    
    func getHabitationalUnitById(id: String) -> HabitationalUnit? {
        guard let idu = UUID(uuidString: id) else { return nil }
        
        var fetchDescriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu })
            fetchDescriptor.fetchLimit = 1
        
        do {
            if let result = try modelContainer.mainContext.fetch(fetchDescriptor).first {
                return HabitationalUnitMapper.toDomain(hu: result)
            } else {
                return nil
            }
        } catch let error {
            print("Error in query for Habitational Unit by Id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getHabitationalUnitModelById(id: String) -> HabitationalUnitModel? {
        guard let idu = UUID(uuidString: id) else { return nil }
        
        var fetchDescriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu })
            fetchDescriptor.fetchLimit = 1
        
        do {
            if let result = try modelContainer.mainContext.fetch(fetchDescriptor).first {
                return result
            } else {
                return nil
            }
        } catch let error {
            print("Error in query for Habitational Unit Model by Id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveDamage(huId: String, damage: Damage) throws {
        if let huModel = getHabitationalUnitModelById(id: huId) {
            let damageModel = DamageMapper.toModel(damage: damage)
            damageModel.habitationalUnitModel = huModel
            
            modelContainer.mainContext.insert(damageModel)
            
            if huModel.damages == nil {
                huModel.damages = []
            }
            
            huModel.damages?.append(damageModel)
            
            try modelContainer.mainContext.save()
        }
    }
    
    func savePayment(huId: String, payment: Payment) throws {
        if let huModel = getHabitationalUnitModelById(id: huId) {
            let paymentModel = PaymentMapper.toModel(payment: payment)
            paymentModel.habitationalUnitModel = huModel
            
            modelContainer.mainContext.insert(paymentModel)
            
            if huModel.payments == nil {
                huModel.payments = []
            }
            
            huModel.payments?.append(paymentModel)
            
            try modelContainer.mainContext.save()
        }
    }
    
    func save(habitationalUnit: HabitationalUnit) throws {
        let model: HabitationalUnitModel = HabitationalUnitMapper.toModel(hu: habitationalUnit)
        
        modelContainer.mainContext.insert(model)
        try modelContainer.mainContext.save()
    }
}
