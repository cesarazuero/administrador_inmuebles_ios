//
//  SavePaymentUseCaseProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 30/10/26.
//

protocol SavePaymentUseCaseProtocol {
    func execute(payment: Payment, habitationalUnitId: String) throws
}
