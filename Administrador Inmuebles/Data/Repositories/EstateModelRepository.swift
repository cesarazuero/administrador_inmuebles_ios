//
//  EstateModelRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 21/10/26.
//
import SwiftData
import Foundation

struct EstateModelRepository: EstateRepositoryProtocol {
    private let modelContainer: ModelContainer
    
    init(_ modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func getAllEstates() -> [Estate]? {
        let fetchDescriptor = FetchDescriptor<EstateModel>(sortBy: [SortDescriptor(\.name, order: .forward)])
        
        do {
            let results = try modelContainer.mainContext.fetch(fetchDescriptor)
            let estates = results.map {
                EstateMapper.toDomain(estateModel: $0)
            }
            
            return estates
        } catch {
            return nil
        }
    }
    
    func getStateById(id: String) -> Estate? {
        guard let idu = UUID(uuidString: id) else { return nil }
        
        var fetchDescriptor = FetchDescriptor<EstateModel>(predicate: #Predicate { $0.id == idu })
            fetchDescriptor.fetchLimit = 1
        
        do {
            if let result = try modelContainer.mainContext.fetch(fetchDescriptor).first {
                return EstateMapper.toDomain(estateModel: result)
            } else {
                return nil
            }
        } catch let error {
            print("Error in query for estates by Id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func save(estate: Estate) throws {
        let estateModel: EstateModel = EstateMapper.toModel(estate: estate)
        
        modelContainer.mainContext.insert(estateModel)
        try modelContainer.mainContext.save()
    }
    
    
}
