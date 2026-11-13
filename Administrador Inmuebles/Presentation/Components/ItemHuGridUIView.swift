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
    let onEventSelected: (RegisterDamagePaymentEvent) -> Void
    
    init(huName: String,
         tenantName: String,
         id: String,
         onEventSelected: @escaping (RegisterDamagePaymentEvent) -> Void) {
        self.huName = huName
        self.tenantName = tenantName
        self.id = id
        self.onEventSelected = onEventSelected
    }
    
    var body: some View {
        HStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 25)
                .stroke(.white, lineWidth: 2)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "house.lodge.fill")
                        .resizable()
                        .frame(width: 35, height: 20)
                        .foregroundStyle(.white)
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
            
            MenuRegisterDamageAndPaymentUIView(onEventSelected: { event in
                onEventSelected(event)
            })
        }
    }
}

#Preview {
    ItemHuGridUIView(huName: "Primavera",
                     tenantName: "Jose Roa",
                     id: "123456",
                     onEventSelected: { event in })
        .preferredColorScheme(.dark)
}
