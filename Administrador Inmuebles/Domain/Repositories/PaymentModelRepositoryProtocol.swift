//
//  PaymentModelRepositoryProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 3/11/26.
//
protocol PaymentModelRepositoryProtocol {
    func getAllPaymentsByHabitationalUnitId(huId: String) async -> [Payment]?
}
