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
            .font(.system(size: 16, weight: .bold, design: .rounded))
    }
}

#Preview {
    HeaderTextUIView(text: .payments)
}
