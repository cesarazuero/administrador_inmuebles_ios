//
//  SaveDamageUseCaseProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 26/10/26.
//
protocol SaveDamageUseCaseProtocol {
    func execute(damage: Damage, habitationalUnitId: String) throws
}
