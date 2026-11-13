//
//  PaymentMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 30/10/26.
//

struct PaymentMapper {
    static func toModel(payment: Payment) -> PaymentModel {
        PaymentModel(id: payment.id,
                     created_at: payment.created_at,
                     payment_date: payment.payment_date,
                     amount: payment.amount,
                     made_by: payment.made_by,
                     bank: payment.bank)
    }
    
    static func toDomain(payment: PaymentModel) -> Payment {
        Payment(id: payment.id,
                created_at: payment.created_at,
                payment_date: payment.payment_date,
                amount: payment.amount,
                made_by: payment.made_by,
                bank: payment.bank)
    }
}
