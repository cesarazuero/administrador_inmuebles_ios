import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/HeaderTextUIView.swift", line: 1)
//
//  HeaderTextUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 4/11/26.
//

import SwiftUI

struct HeaderTextUIView: View {
    let text: LocalizedStringResource
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.system(size: __designTimeInteger("#54305_0", fallback: 16), weight: .bold, design: .rounded))
    }
}

#Preview {
    HeaderTextUIView(text: .payments)
}
