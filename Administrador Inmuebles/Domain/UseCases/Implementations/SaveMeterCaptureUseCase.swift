//
//  SaveMeterCaptureUseCase.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

struct SaveMeterCaptureUseCase: SaveMeterCaptureUseCaseProtocol {
    let meterRepository: MeterCaptureRepository
    
    init(meterRepository: MeterCaptureRepository) {
        self.meterRepository = meterRepository
    }
    
    func execute(meter: MeterCapture, habitationalUnitId: String) async throws {
        try await meterRepository.save(meter: meter, huId: habitationalUnitId)
    }
    
    
}
