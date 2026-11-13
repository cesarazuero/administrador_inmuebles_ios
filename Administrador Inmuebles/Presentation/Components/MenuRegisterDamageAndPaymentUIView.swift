//
//  MenuRegisterDamageAndPaymentUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 4/11/26.
//

import SwiftUI

struct MenuRegisterDamageAndPaymentUIView: View {
    let onEventSelected: (RegisterDamagePaymentEvent) -> Void
    
    var body: some View {
        Menu {
            Button {
                onEventSelected(.damage)
            } label: {
                Label(.registerDamage, systemImage: "wrench.adjustable")
            }
            
            Button {
                onEventSelected(.payment)
            } label: {
                Label(.registerPayment, systemImage: "dollarsign")
            }
            
            Button {
                onEventSelected(.call)
            } label: {
                Label(.callTenant, systemImage: "phone")
            }
            
            Button {
                onEventSelected(.sendEmail)
            } label: {
                Label(.sendEmailTenant, systemImage: "envelope")
            }
            
            Button {
                onEventSelected(.sendWhatsApp)
            } label: {
                Label(.sendWhatsappTenant, systemImage: "message")
            }
            
            Menu {
                Button{
                    onEventSelected(.registerEnergy)
                } label: {
                    Label(.registerEnergy, systemImage: "bolt")
                }
                
                Button{
                    onEventSelected(.registerGas)
                } label: {
                    Label(.registerGas, systemImage: "flame")
                }
                
                Button{
                    onEventSelected(.registerWater)
                } label: {
                    Label(.registerWater, systemImage: "drop")
                }
            } label: {
                Label(.registerReading, systemImage: "powermeter")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
                .font(.title2)
                .labelStyle(.iconOnly)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MenuRegisterDamageAndPaymentUIView(onEventSelected: { event in })
}
