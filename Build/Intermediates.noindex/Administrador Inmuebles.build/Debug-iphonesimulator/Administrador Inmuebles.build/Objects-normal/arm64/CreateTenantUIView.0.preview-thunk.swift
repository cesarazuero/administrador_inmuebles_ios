#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/CreateTenant/CreateTenantUIView.swift", line: 1)
//
//  CreateTenantUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 9/10/26.
//

import SwiftUI

struct CreateTenantUIView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: CreateTenantViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            List {
                Section {
                    TextField(.name,
                              text: $viewModel.tenant.name)
                }
                
                Section {
                    idTypePicker
                    
                    TextField(.identification,
                              text: $viewModel.tenant.identification)
                } header: {
                    HeaderTextUIView(text: .identification)
                }
            }
            .background(.black)
            .scrollContentBackground(.hidden)
        }
        .toolbar {
            Button(.save,
                   systemImage: "checkmark",
                   role: viewModel.btnDoneRole,
                   action: {
                if viewModel.saveTenant() {
                    dismiss()
                }
            })
            .disabled(viewModel.btnDoneRole != .confirm)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .onChange(of: viewModel.tenant.name) { _ in
            viewModel.checkFormStatus()
        }
        .onChange(of: viewModel.tenant.identification) { _ in
            viewModel.checkFormStatus()
        }
        .navigationTitle(.tenant)
    }
    
    var idTypePicker: some View {
        Picker(.select,
               selection: $viewModel.tenant.identification_type) {
            Text(.cedula).tag("CC")
            Text(.cedulaExtranjeria).tag("CE")
            Text(.passport).tag("P")
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    NavigationStack {
        var estate = Estate()
        
        let vm = CreateTenantViewModel(estate: estate, huId: nil)
        CreateTenantUIView(viewModel: vm)
    }
}
