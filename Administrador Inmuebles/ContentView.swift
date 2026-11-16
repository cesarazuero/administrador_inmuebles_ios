//
//  ContentView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var estates: [EstateModel]    
    @State private var router = DependencyContainer.shared.getRouter()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            NavigationStack(path: $router.path) {
                Group {
                    if estates.isEmpty {
                        emptyContent
                    } else {
                        navigationList
                    }
                }
                .navigationDestination(for: Screen.self) { screen in
                    switch screen.kind {
                    case .createEstate(let vm):
                        CreateEstateUIView(viewModel: vm)
                    case .createHabitationalUnit(let vm):
                        CreateHabitationalUnitUIView(viewModel: vm)
                    case .createTenant(let vm):
                        CreateTenantUIView(viewModel: vm)
                    case .detailEstate(let vm, let mcvm):
                        DetailEstateUIView(viewModel: vm, meterCaptureViewModel: mcvm)
                    case .detailHabitationalUnit(let huId, let vm, let mcvm, let fcvm):
                        DetailHabitationalUnitUIView(huId: huId,
                                                     viewModel: vm,
                                                     meterCaptureViewModel: mcvm,
                                                     feeCalculationViewModel: fcvm)
                    case .settings(let vm):
                        SettingsUIView(viewModel: vm)
                    }
                }
            }
        }
    }
    
    var emptyContent: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 13) {
                Spacer()
                
                Image("Logo_sin_casa")
                    .resizable()
                    .frame(width: 200, height: 150)
                
                Text(.noEstateCreated)
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    router.navigateTo(route: .createEstate(id: nil))
                } label: {
                    HStack {
                        Image(systemName: "hammer")
                            .renderingMode(.template)
                            .tint(Color("light_green_button"))
                        Text(.createFirstEstate)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(Color("light_green_button"))
                    }
                    .padding(15)
                    .frame(height: 40.0)
                    .background {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color("dark_green_button"))
                    }
                }
            }
        }
    }
    
    var navigationList: some View {
        List {
            ForEach(estates) { estate in
                let estate = EstateMapper.toDomain(estateModel: estate)
                
                Button {
                    router.navigateTo(route: Destination.detailEstate(estate: estate))
                } label: {
                    estateView(estate: estate)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        DependencyContainer.shared.updateEstate(id: estate.id.uuidString)
                        router.navigateTo(route: .createEstate(id: estate.id.uuidString))
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.green)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.horizontal, 10)
        .padding(.top, 20)
        .navigationTitle(.myEstates)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    router.navigateTo(route: Destination.settings)
                } label: {
                    Image(systemName: "gearshape")
                    .foregroundColor(.white)
                }
                
                Button {
                    DependencyContainer.shared.clearEstate()
                    router.navigateTo(route: Destination.createEstate(id: nil))
                } label: {
                    Image(systemName: "plus.circle")
                    .foregroundColor(.white)
                }
            }
        }
        .background(.black)
    }
    
    @ViewBuilder
    private func estateView(estate: Estate) -> some View {
        HStack(spacing: 20) {
            Image(systemName: "house")
                .resizable()
                .frame(width: 30, height: 30)
                .tint(.white)
            
            VStack (alignment: .leading) {
                Text(estate.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(estate.address)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.darkGrayBackground)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: EstateModel.self, configurations: config)
    let inmueble1 = EstateModel()
    inmueble1.name = "Primavera"
    inmueble1.address = "Carrera 50 # 3-34"
    
    let inmueble2 = EstateModel()
    inmueble2.name = "Colonia Oriental"
    inmueble2.address = "Calle 4Bis # 51A - 13"
    
    container.mainContext.insert(inmueble1)
    container.mainContext.insert(inmueble2)
    
    return ContentView()
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
