import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

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
        HStack(spacing: __designTimeInteger("#9784_0", fallback: 15)) {
            Button {
            } label: {
                RoundedRectangle(cornerRadius: __designTimeInteger("#9784_1", fallback: 25))
                    .stroke(.white, lineWidth: __designTimeInteger("#9784_2", fallback: 2))
                    .frame(width: __designTimeInteger("#9784_3", fallback: 50), height: __designTimeInteger("#9784_4", fallback: 50))
                    .overlay {
                        Image(systemName: __designTimeString("#9784_5", fallback: "house.lodge.fill"))
                            .resizable()
                            .frame(width: __designTimeInteger("#9784_6", fallback: 35), height: __designTimeInteger("#9784_7", fallback: 20))
                            .foregroundStyle(.white)
                    }
            }
            
            VStack(alignment: .leading) {
                Text(huName)
                    .font(.system(size: __designTimeInteger("#9784_8", fallback: 18), weight: .bold, design: .rounded))
                    .truncationMode(.tail)
                
                Text(tenantName)
                    .font(.system(size: __designTimeInteger("#9784_9", fallback: 16), weight: .regular, design: .rounded))
                    .truncationMode(.tail)
            }
            
            Spacer()
            
            MenuRegisterDamageAndPaymentUIView(onDamageSelected: onDamageSelected,
                                               onPaymentSelected: onPaymentSelected)
        }
    }
}

#Preview {
    ItemHuGridUIView(huName: __designTimeString("#9784_10", fallback: "Primavera"),
                     tenantName: __designTimeString("#9784_11", fallback: "Jose Roa"),
                     id: __designTimeString("#9784_12", fallback: "123456"),
                     onDamageSelected: {},
                     onPaymentSelected: {})
        .preferredColorScheme(.dark)
}
