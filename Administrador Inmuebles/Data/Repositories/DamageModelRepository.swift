//
//  DamageModelRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 3/11/26.
//
import SwiftData
import Foundation

struct DamageModelRepository: DamageModelRepositoryProtocol {
    func getAllDamageByHabitationalUnitId(huId: String) async -> [Damage]? {
        let modelConfiguration = ModelConfiguration(schema: DependencyContainer.schema, isStoredInMemoryOnly: false)
        
        guard let idu = UUID(uuidString: huId),
              let container = try? ModelContainer(for: DependencyContainer.schema, configurations: [modelConfiguration]) else { return nil }
        
        var fetchDescriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu })
            fetchDescriptor.fetchLimit = 1
        
        do {
            let modelContext = ModelContext(container)
            let results = try modelContext.fetch(fetchDescriptor)
            
            if let huModel = results.first, let damages = huModel.damages {
                return damages.map { DamageMapper.toDomain(damage: $0) }
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
