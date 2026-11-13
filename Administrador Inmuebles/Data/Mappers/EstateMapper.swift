//
//  EstateMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//
import SwiftData

struct EstateMapper {
    static func toModel(estate: Estate) -> EstateModel {
        EstateModel(id: estate.id,
                    name: estate.name,
                    address: estate.address,
                    habitationalUnits: estate.habitationalUnits?.map { HabitationalUnitMapper.toModel(hu: $0) })
    }
    
    static func toDomain(estateModel: EstateModel) -> Estate {
        Estate(id: estateModel.id,
               name: estateModel.name,
               address: estateModel.address,
               habitationalUnits: estateModel.habitationalUnits?.map { HabitationalUnitMapper.toDomain(hu: $0) })
    }
}
