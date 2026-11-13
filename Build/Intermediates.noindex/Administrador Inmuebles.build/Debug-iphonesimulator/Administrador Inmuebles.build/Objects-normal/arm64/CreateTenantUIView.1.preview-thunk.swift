import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

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
                
                Section {
                    TextField(.phoneNumber,
                              value: $viewModel.tenant.phoneNumber,
                              formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    
                    TextField(.email,
                              text: Binding(
                                  get: { viewModel.tenant.email },
                                  set: { newValue in
                                      viewModel.tenant.email = newValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                                  }
                              ))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(__designTimeBoolean("#58811_0", fallback: true))
                } header: {
                    HeaderTextUIView(text: .contact)
                }
            }
            .background(.black)
            .scrollContentBackground(.hidden)
        }
        .toolbar {
            Button(.save,
                   systemImage: __designTimeString("#58811_1", fallback: "checkmark"),
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
        .onChange(of: viewModel.tenant.email) { _ in
            viewModel.checkFormStatus()
        }
        .onChange(of: viewModel.tenant.phoneNumber) { _ in
            viewModel.checkFormStatus()
        }
        .navigationTitle(.tenant)
    }
    
    var idTypePicker: some View {
        Picker(.select,
               selection: $viewModel.tenant.identification_type) {
            Text(.cedula).tag(__designTimeString("#58811_2", fallback: "CC"))
            Text(.cedulaExtranjeria).tag(__designTimeString("#58811_3", fallback: "CE"))
            Text(.passport).tag(__designTimeString("#58811_4", fallback: "P"))
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    NavigationStack {
        var estate = Estate()
        
        let vm = CreateTenantViewModel(estate: estate, huId: nil)
        CreateTenantUIView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
