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
                Image("Logo")
                    .resizable()
                    .frame(width: 170, height: 120)
                
                form
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(.save,
                       systemImage: "checkmark",
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
                    Image(systemName: "chevron.left")
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
                    HStack(spacing: 45) {
                        getViewHU(label: String(localized: "Create"), id: nil)
                        
                        if let units = viewModel.estate.habitationalUnits {
                            ForEach(units, id: \.id) { hu in
                                getViewHU(label: hu.name, id: hu.id.uuidString)
                            }
                        }
                    }
                    .padding(3)
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
        VStack(spacing: 5) {
            Button(action: {
                viewModel.goToCreateHabitationalUnit(id: id)
            },
                   label: {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "house.lodge.fill")
                            .resizable()
                            .frame(width: 35, height: 20)
                            .foregroundStyle(.white)
                    }
            })
            
            Text(label)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(maxWidth: 80)
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
    hu1.name = "HU1"
    hu1.tenant = tenant
    
    var hu2 = HabitationalUnitModel()
    hu2.name = "HU2 - Titulo súper largo"
    hu2.tenant = tenant
    
    var hu3 = HabitationalUnitModel()
    hu3.name = "HU3"
    hu3.tenant = tenant
    
    var hu4 = HabitationalUnitModel()
    hu4.name = "HU4"
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
