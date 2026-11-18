//
//  HabitationalUnitsMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

struct HabitationalUnitMapper {
    static func toModel(hu: HabitationalUnit) -> HabitationalUnitModel {
        HabitationalUnitModel(id: hu.id,
                              name: hu.name,
                              tenant: hu.tenant.map { TenantMapper.toModel(tenant: $0) },
                              dueDateEnergyDay: hu.dueDateEnergyDay,
                              dueDateWaterDay: hu.dueDateWaterDay,
                              dueDateGasDay: hu.dueDateGasDay,
                              rentAmount: hu.rentAmount,
                              dateBeginRent: hu.dateBeginRent,
                              documentPDF: hu.documentPDF,
                              documentPDFName: hu.documentPDFName,
                              adText: hu.adText,
                              adPhotoFileNames: hu.adPhotoFileNames,
                              adVideoFileName: hu.adVideoFileName,
                              damages: hu.damages?.map { DamageMapper.toModel(damage: $0) },
                              meterCaptures: hu.meterCaptures?.map { MeterCaptureMapper.toModel(meterCapture: $0) })
    }
    
    static func toDomain(hu: HabitationalUnitModel) -> HabitationalUnit {
        return HabitationalUnit(id: hu.id,
                                name: hu.name,
                                tenant: hu.tenant.map { TenantMapper.toDomain(tenant: $0) },
                                dueDateEnergyDay: hu.dueDateEnergyDay,
                                dueDateWaterDay: hu.dueDateWaterDay,
                                dueDateGasDay: hu.dueDateGasDay,
                                rentAmount: hu.rentAmount,
                                dateBeginRent: hu.dateBeginRent,
                                documentPDF: hu.documentPDF,
                                documentPDFName: hu.documentPDFName,
                                adText: hu.adText,
                                adPhotoFileNames: hu.adPhotoFileNames,
                                adVideoFileName: hu.adVideoFileName,
                                damages: hu.damages?.map { DamageMapper.toDomain(damage: $0) },
                                meterCaptures: hu.meterCaptures?.map { MeterCaptureMapper.toDomain(meterCapture: $0) })
    }
}
