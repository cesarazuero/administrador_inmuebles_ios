import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/CreateEstate/CreateEstateUIView.swift", line: 1)
//
//  CreateEstateUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import SwiftUI
import SwiftData

struct CreateEstateUIView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: CreateEstateViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image(__designTimeString("#17139_0", fallback: "Logo"))
                    .resizable()
                    .frame(width: __designTimeInteger("#17139_1", fallback: 170), height: __designTimeInteger("#17139_2", fallback: 120))
                
                form
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(.save,
                       systemImage: __designTimeString("#17139_3", fallback: "checkmark"),
                       role: viewModel.btnDoneRole,
                       action: {
                    Keyboard.hideKeyboard()
                    
                    if viewModel.saveEstate() {
                        dismiss()
                    }
                })
                .disabled(viewModel.btnDoneRole != .confirm)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Keyboard.hideKeyboard()
                    
                    viewModel.goBack()
                } label: {
                    Image(systemName: __designTimeString("#17139_4", fallback: "chevron.left"))
                    .foregroundColor(.white)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .onChange(of: viewModel.estate.name) {
            viewModel.checkFormStatus()
        }
        .onChange(of: viewModel.estate.address) {
            viewModel.checkFormStatus()
        }
        .onChange(of: viewModel.estate.habitationalUnits) {
            viewModel.checkFormStatus()
        }
        .navigationBarBackButtonHidden()
    }
    
    var form: some View {
        List {
            Section {
                TextField(.name,
                          text: $viewModel.estate.name)
                
                TextField(.address,
                          text: $viewModel.estate.address)
            }
            
            Section {
                ScrollView(.horizontal) {
                    HStack(spacing: __designTimeInteger("#17139_5", fallback: 45)) {
                        getViewHU(label: String(localized: __designTimeString("#17139_6", fallback: "Create")), id: nil)
                        
                        if let units = viewModel.estate.habitationalUnits {
                            ForEach(units, id: \.id) { hu in
                                getViewHU(label: hu.name, id: hu.id.uuidString)
                            }
                        }
                    }
                    .padding(__designTimeInteger("#17139_7", fallback: 3))
                }
                .scrollIndicators(.hidden)
            } header: {
                HeaderTextUIView(text: .habitationalUnits)
            }
        }
        .background(.black)
        .scrollContentBackground(.hidden)
    }
    
    func getViewHU(label: String, id: String?) -> some View {
        VStack(spacing: __designTimeInteger("#17139_8", fallback: 5)) {
            Button(action: {
                viewModel.goToCreateHabitationalUnit(id: id)
            },
                   label: {
                RoundedRectangle(cornerRadius: __designTimeInteger("#17139_9", fallback: 25))
                    .stroke(.white, lineWidth: __designTimeInteger("#17139_10", fallback: 2))
                    .frame(width: __designTimeInteger("#17139_11", fallback: 50), height: __designTimeInteger("#17139_12", fallback: 50))
                    .overlay {
                        Image(systemName: __designTimeString("#17139_13", fallback: "house.lodge.fill"))
                            .resizable()
                            .frame(width: __designTimeInteger("#17139_14", fallback: 35), height: __designTimeInteger("#17139_15", fallback: 20))
                            .foregroundStyle(.white)
                    }
            })
            
            Text(label)
                .font(.system(size: __designTimeInteger("#17139_16", fallback: 16), weight: .regular, design: .rounded))
                .frame(maxWidth: __designTimeInteger("#17139_17", fallback: 80))
                .truncationMode(.tail)
        }
    }
}

#Preview {
    let schema = Schema([EstateModel.self,
                         HabitationalUnitModel.self,
                         TenantModel.self])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: [config])
    
    var inmueble = EstateModel()
    var tenant = TenantModel()
    var hu1 = HabitationalUnitModel()
    hu1.name = __designTimeString("#17139_18", fallback: "HU1")
    hu1.tenant = tenant
    
    var hu2 = HabitationalUnitModel()
    hu2.name = __designTimeString("#17139_19", fallback: "HU2 - Titulo súper largo")
    hu2.tenant = tenant
    
    var hu3 = HabitationalUnitModel()
    hu3.name = __designTimeString("#17139_20", fallback: "HU3")
    hu3.tenant = tenant
    
    var hu4 = HabitationalUnitModel()
    hu4.name = __designTimeString("#17139_21", fallback: "HU4")
    hu4.tenant = tenant
    
    inmueble.habitationalUnits = [hu1, hu2, hu3, hu4]
    
    container.mainContext.insert(tenant)
    container.mainContext.insert(hu1)
    container.mainContext.insert(hu2)
    container.mainContext.insert(hu3)
    container.mainContext.insert(hu4)
    container.mainContext.insert(inmueble)
    
    let saveEstateUseCase = SaveEstateUseCase(modelContext: container.mainContext,
                                              estateRepository: EstateModelRepository(container))
    
    return NavigationStack {
        let vm = DependencyContainer.shared.createEstateViewModel(id: nil)
        
        CreateEstateUIView(viewModel: vm)
            .modelContainer(container)
            .preferredColorScheme(.dark)
    }
}
