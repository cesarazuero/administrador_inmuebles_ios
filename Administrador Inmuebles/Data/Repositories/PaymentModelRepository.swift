//
//  PaymentModelRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 3/11/26.
//
import SwiftData
import Foundation

struct PaymentModelRepository: PaymentModelRepositoryProtocol {
    func getAllPaymentsByHabitationalUnitId(huId: String) async -> [Payment]? {
        let modelConfiguration = ModelConfiguration(schema: DependencyContainer.schema, isStoredInMemoryOnly: false)
        
        guard let idu = UUID(uuidString: huId),
              let container = try? ModelContainer(for: DependencyContainer.schema, configurations: [modelConfiguration]) else { return nil }
        
        var fetchDescriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu })
            fetchDescriptor.fetchLimit = 1
        
        do {
            let modelContext = ModelContext(container)
            let results = try modelContext.fetch(fetchDescriptor)
            
            if let huModel = results.first, let payments = huModel.payments {
                return payments.map {
                    PaymentMapper.toDomain(payment: $0)
                }
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
