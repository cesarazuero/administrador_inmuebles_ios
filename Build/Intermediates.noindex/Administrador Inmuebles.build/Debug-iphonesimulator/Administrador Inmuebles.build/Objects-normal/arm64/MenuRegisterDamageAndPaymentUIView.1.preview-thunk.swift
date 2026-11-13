import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/MenuRegisterDamageAndPaymentUIView.swift", line: 1)
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
                Label(.registerDamage, systemImage: __designTimeString("#51040_0", fallback: "wrench.adjustable"))
            }
            
            Button {
                onEventSelected(.payment)
            } label: {
                Label(.registerPayment, systemImage: __designTimeString("#51040_1", fallback: "dollarsign"))
            }
            
            Button {
                onEventSelected(.call)
            } label: {
                Label(.callTenant, systemImage: __designTimeString("#51040_2", fallback: "phone"))
            }
            
            Button {
                onEventSelected(.sendEmail)
            } label: {
                Label(.sendEmailTenant, systemImage: __designTimeString("#51040_3", fallback: "envelope"))
            }
            
            Button {
                onEventSelected(.sendWhatsApp)
            } label: {
                Label(.sendWhatsappTenant, systemImage: __designTimeString("#51040_4", fallback: "message"))
            }
            
            Menu {
                Button{
                    onEventSelected(.registerEnergy)
                } label: {
                    Label(.registerEnergy, systemImage: __designTimeString("#51040_5", fallback: "bolt"))
                }
                
                Button{
                    onEventSelected(.registerGas)
                } label: {
                    Label(.registerGas, systemImage: __designTimeString("#51040_6", fallback: "flame"))
                }
                
                Button{
                    onEventSelected(.registerWater)
                } label: {
                    Label(.registerWater, systemImage: __designTimeString("#51040_7", fallback: "drop"))
                }
            } label: {
                Label(.registerReading, systemImage: __designTimeString("#51040_8", fallback: "powermeter"))
            }
        } label: {
            Label(__designTimeString("#51040_9", fallback: ""), systemImage: __designTimeString("#51040_10", fallback: "ellipsis.circle"))
                .font(.title2)
                .labelStyle(.iconOnly)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MenuRegisterDamageAndPaymentUIView(onEventSelected: { event in })
}
