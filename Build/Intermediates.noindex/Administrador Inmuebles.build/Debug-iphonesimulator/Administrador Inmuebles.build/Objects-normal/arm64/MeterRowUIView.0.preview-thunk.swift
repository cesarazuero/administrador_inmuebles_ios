#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/MeterRowUIView.swift", line: 1)
//
//  MeterRowUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

import SwiftUI

struct MeterRowUIView: View {
    let measure: Double
    let date: Date
    
    var body: some View {
        HStack(spacing: 0){
            Text(String(measure))
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .background {
                    Rectangle().stroke(.white)
                }
            
            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 10)
                .background {
                    Rectangle().stroke(.white)
                }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    MeterRowUIView(measure: 123.45, date: Date())
        .preferredColorScheme(.dark)
}
