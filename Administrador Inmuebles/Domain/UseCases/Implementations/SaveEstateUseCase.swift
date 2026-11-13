//
//  SaveEstateUseCase.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//
import SwiftData
import Foundation

struct SaveEstateUseCase: SaveEstateUseCaseProtocol {
    private let modelContext: ModelContext
    private let estateRepository: EstateRepositoryProtocol
    
    init(modelContext: ModelContext, estateRepository: EstateRepositoryProtocol) {
        self.modelContext = modelContext
        self.estateRepository = estateRepository
    }
    
    func execute(estate: Estate) throws {
        try estateRepository.save(estate: estate)
    }
}
