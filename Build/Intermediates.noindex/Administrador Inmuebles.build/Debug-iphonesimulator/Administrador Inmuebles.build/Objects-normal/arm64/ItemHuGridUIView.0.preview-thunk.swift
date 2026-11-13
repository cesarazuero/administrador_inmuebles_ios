#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/ItemHuGridUIView.swift", line: 1)
//
//  ItemHuGridUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 27/10/26.
//

import SwiftUI

struct ItemHuGridUIView: View {
    let huName: String
    let tenantName: String
    let id: String
    let onDamageSelected: () -> Void
    let onPaymentSelected: () -> Void
    
    init(huName: String,
         tenantName: String,
         id: String,
         onDamageSelected: @escaping () -> Void,
         onPaymentSelected: @escaping () -> Void) {
        self.huName = huName
        self.tenantName = tenantName
        self.id = id
        self.onDamageSelected = onDamageSelected
        self.onPaymentSelected = onPaymentSelected
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Button {
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "house.lodge.fill")
                            .resizable()
                            .frame(width: 35, height: 20)
                            .foregroundStyle(.white)
                    }
            }
            
            VStack(alignment: .leading) {
                Text(huName)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .truncationMode(.tail)
                
                Text(tenantName)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .truncationMode(.tail)
            }
            
            Spacer()
            
            MenuRegisterDamageAndPaymentUIView(onDamageSelected: onDamageSelected,
                                               onPaymentSelected: onPaymentSelected)
        }
    }
}

#Preview {
    ItemHuGridUIView(huName: "Primavera",
                     tenantName: "Jose Roa",
                     id: "123456",
                     onDamageSelected: {},
                     onPaymentSelected: {})
        .preferredColorScheme(.dark)
}
