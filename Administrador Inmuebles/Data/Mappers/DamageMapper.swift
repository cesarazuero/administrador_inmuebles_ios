//
//  DamageMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

struct DamageMapper {
    static func toModel(damage: Damage) -> DamageModel {
        DamageModel(id: damage.id,
                    damage: damage.damage,
                    created_at: damage.created_at,
                    state: damage.state,
                    issuer: damage.issuer,
                    photoPaths: damage.photoPaths)
    }
    
    static func toDomain(damage: DamageModel) -> Damage {
        Damage(id: damage.id,
               damage: damage.damage,
               created_at: damage.created_at,
               state: damage.state,
               issuer: damage.issuer,
               photoPaths: damage.photoPaths)
    }
}
