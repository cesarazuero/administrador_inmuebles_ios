//
//  MeterCaptureRepository.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//
import SwiftData
import Foundation

@ModelActor
actor MeterCaptureRepository: MeterCaptureModelRepositoryProtocol {
    func save(meter: MeterCapture, huId: String) async throws {
        guard let idu = UUID(uuidString: huId) else { return }

        var descriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu })
        descriptor.fetchLimit = 1

        guard let hu = try modelContext.fetch(descriptor).first else { return }
        
        let model = await MeterCaptureModel(type: meter.type,
                                            measure: meter.measure,
                                            date: meter.date)
        
        if hu.meterCaptures == nil {
            hu.meterCaptures = [model]
        } else {
            hu.meterCaptures?.append(model)
        }
        
        modelContext.insert(model)
        try modelContext.save()
    }
    
}
