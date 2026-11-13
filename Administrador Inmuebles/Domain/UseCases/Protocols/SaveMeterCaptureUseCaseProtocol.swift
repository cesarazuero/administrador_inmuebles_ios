//
//  SaveMeterCaptureUseCaseProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

protocol SaveMeterCaptureUseCaseProtocol {
    func execute(meter: MeterCapture, habitationalUnitId: String) async throws
}
