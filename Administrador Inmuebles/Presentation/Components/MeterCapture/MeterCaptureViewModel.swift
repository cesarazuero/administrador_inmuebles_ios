//
//  MeterCaptureViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//
import SwiftUI

@Observable
final class MeterCaptureViewModel {
    var presentMeterCapture = false
    var measure: String = ""
    var processing: ProcessingStatus = .noProcessing
    var huId: String?
    var typeSelected: PublicServices = .water
    var dateSelected: Date = Date()
    let saveMeterUseCase: SaveMeterCaptureUseCaseProtocol
    
    init(saveMeterUseCase: SaveMeterCaptureUseCaseProtocol) {
        self.saveMeterUseCase = saveMeterUseCase
    }
    
    func displayMeterCapture(huId: String, service: PublicServices) {
        self.huId = huId
        self.typeSelected = service
        presentMeterCapture = true
    }
    
    func saveMeter() {
        let measureFormatted = measure.replacingOccurrences(of: ",", with: ".")
        
        guard let measureCant = Double(measureFormatted), let huId = huId else { return }
        
        let meterCapture = MeterCapture(type: typeSelected,
                                        measure: measureCant,
                                        date: dateSelected)
        
        Task {
            do {
                processing = .processing
                try await saveMeterUseCase.execute(meter: meterCapture, habitationalUnitId: huId)
                processing = .success
            } catch {
                processing = .failure
            }
        }
    }
    
    func clearAll() {
        measure = ""
        processing = .noProcessing
    }
}
