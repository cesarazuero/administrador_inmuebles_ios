import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/Settings/SettingsUIView.swift", line: 1)
//
//  SettingsUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

import SwiftUI

struct SettingsUIView: View {
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            Color.clear
            
            List {
                // MARK: ----------------------- NOTIFICATIONS ---------------------
                Section {
                    HStack {
                        Text(.notificationsForGas)
                            .font(.system(size: __designTimeInteger("#130971_0", fallback: 16), weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle(__designTimeString("#130971_1", fallback: ""), isOn: $viewModel.notificationsGas)
                    }
                    
                    HStack {
                        Text(.notificationsForEnergy)
                            .font(.system(size: __designTimeInteger("#130971_2", fallback: 16), weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle(__designTimeString("#130971_3", fallback: ""), isOn: $viewModel.notificationsEnergy)
                    }
                    
                    HStack {
                        Text(.notificationsForWater)
                            .font(.system(size: __designTimeInteger("#130971_4", fallback: 16), weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle(__designTimeString("#130971_5", fallback: ""), isOn: $viewModel.notificationsWater)
                    }
                }
                header: {
                    HeaderTextUIView(text: .notifications)
                }
            }
        }
        .navigationTitle(.settings)
    }
}

#Preview {
    let vm = SettingsViewModel()
    
    NavigationStack {
        SettingsUIView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
