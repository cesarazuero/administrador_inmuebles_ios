//
//  DamageModelRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 26/10/26.
//

protocol DamageModelRepositoryProtocol {
    func getAllDamageByHabitationalUnitId(huId: String) async -> [Damage]?
}
