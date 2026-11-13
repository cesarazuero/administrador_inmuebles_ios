import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

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
        HStack(spacing: __designTimeInteger("#28500_0", fallback: 0)){
            Text(String(measure))
                .font(.system(size: __designTimeInteger("#28500_1", fallback: 16), weight: .regular, design: .rounded))
                .lineLimit(__designTimeInteger("#28500_2", fallback: 1))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, __designTimeInteger("#28500_3", fallback: 10))
                .background {
                    Rectangle().stroke(.white)
                }
            
            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: __designTimeInteger("#28500_4", fallback: 16), weight: .regular, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, __designTimeInteger("#28500_5", fallback: 10))
                .background {
                    Rectangle().stroke(.white)
                }
        }
        .padding(.horizontal, __designTimeInteger("#28500_6", fallback: 15))
    }
}

#Preview {
    MeterRowUIView(measure: __designTimeFloat("#28500_7", fallback: 123.45), date: Date())
        .preferredColorScheme(.dark)
}
