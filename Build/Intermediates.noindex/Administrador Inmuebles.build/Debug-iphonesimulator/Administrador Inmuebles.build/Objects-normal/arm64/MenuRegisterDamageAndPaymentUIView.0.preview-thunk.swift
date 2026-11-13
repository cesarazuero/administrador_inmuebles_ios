#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/MenuRegisterDamageAndPaymentUIView.swift", line: 1)
//
//  MenuRegisterDamageAndPaymentUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 4/11/26.
//

import SwiftUI

struct MenuRegisterDamageAndPaymentUIView: View {
    let onDamageSelected: () -> Void
    let onPaymentSelected: () -> Void
    
    var body: some View {
        Menu {
            Button {
                onDamageSelected()
            } label: {
                Label(.registerDamage, systemImage: "wrench.adjustable")
            }
            
            Button {
                onPaymentSelected()
            } label: {
                Label(.registerPayment, systemImage: "dollarsign")
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
    MenuRegisterDamageAndPaymentUIView(onDamageSelected: {}, onPaymentSelected: {})
}
