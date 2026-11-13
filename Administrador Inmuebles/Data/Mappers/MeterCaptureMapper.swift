//
//  MeterCaptureMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

struct MeterCaptureMapper {
    static func toModel(meterCapture: MeterCapture) -> MeterCaptureModel {
        MeterCaptureModel(id: meterCapture.id,
                          type: meterCapture.type,
                          measure: meterCapture.measure,
                          date: meterCapture.date)
    }

    static func toDomain(meterCapture: MeterCaptureModel) -> MeterCapture {
        MeterCapture(id: meterCapture.id,
                     type: meterCapture.type,
                     measure: meterCapture.measure,
                     date: meterCapture.date)
    }
}
