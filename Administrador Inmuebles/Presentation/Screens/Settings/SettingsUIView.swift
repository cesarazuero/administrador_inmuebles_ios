//
//  SettingsUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/11/26.
//

import SwiftUI
import SwiftData

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
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.notificationsGas)
                    }
                    
                    HStack {
                        Text(.notificationsForEnergy)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.notificationsEnergy)
                    }
                    
                    HStack {
                        Text(.notificationsForWater)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Toggle("", isOn: $viewModel.notificationsWater)
                    }
                }
                header: {
                    HeaderTextUIView(text: .notifications)
                }
            }
        }
        .onChange(of: viewModel.notificationsGas) { old, new in
            new ? viewModel.enableNotificationsFor(service: .gas) : viewModel.disableNotificationsFor(service: .gas)
        }
        .onChange(of: viewModel.notificationsEnergy) { old, new in
            new ? viewModel.enableNotificationsFor(service: .energy) : viewModel.disableNotificationsFor(service: .energy)
        }
        .onChange(of: viewModel.notificationsWater) { old, new in
            new ? viewModel.enableNotificationsFor(service: .water) : viewModel.disableNotificationsFor(service: .water)
        }
        
        .navigationTitle(.settings)
    }
}

#Preview {
    let vm = DependencyContainer.shared.createSettingsViewModel()
    
    NavigationStack {
        SettingsUIView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
