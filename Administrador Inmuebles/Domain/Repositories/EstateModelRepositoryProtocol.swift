//
//  EstateRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

protocol EstateRepositoryProtocol {
    func getAllEstates() -> [Estate]?
    func getStateById(id: String) -> Estate?
    func save(estate: Estate) throws
}
