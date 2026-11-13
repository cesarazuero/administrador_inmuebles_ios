//
//  MeterCaptureModelRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

protocol MeterCaptureModelRepositoryProtocol {
    func save(meter: MeterCapture, huId: String) async throws
}
