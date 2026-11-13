import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/ContentView.swift", line: 1)
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
                if estates.isEmpty {
                    emptyContent
                        .navigationDestination(for: Destination.self) { destination in
                            switch destination {
                            case .createEstate(let id):
                                let vm = DependencyContainer.shared.createEstateViewModel(id: id)
                                CreateEstateUIView(viewModel: vm)
                            case .createHabitationalUnit(let id):
                                let vm = DependencyContainer.shared.createHabitationalUnitViewModel(id: id)
                                CreateHabitationalUnitUIView(viewModel: vm)
                            case .createTenant(let huId):
                                let vm = DependencyContainer.shared.createTenantViewModel(huId: huId)
                                CreateTenantUIView(viewModel: vm)
                            default:
                                EmptyView()
                            }
                        }
                } else {
                    navigationList
                        .navigationDestination(for: Destination.self) { destination in
                            switch destination {
                            case .detailEstate(let estate):
                                let vm = DependencyContainer.shared.createDetailEstateViewModel(estate: estate)
                                DetailEstateUIView(viewModel: vm)
                            case .createEstate(let id):
                                let vm = DependencyContainer.shared.createEstateViewModel(id: id)
                                CreateEstateUIView(viewModel: vm)
                            case .createHabitationalUnit(let id):
                                let vm = DependencyContainer.shared.createHabitationalUnitViewModel(id: id)
                                CreateHabitationalUnitUIView(viewModel: vm)
                            case .createTenant(let huId):
                                let vm = DependencyContainer.shared.createTenantViewModel(huId: huId)
                                CreateTenantUIView(viewModel: vm)
                            case .detailHabitationalUnit(let huId):
                                let vm = DependencyContainer.shared.createDetailHabitationalUnitViewModel(huId: huId)
                                DetailHabitationalUnitUIView(huId: huId, viewModel: vm)
                            }
                        }
                }
            }
        }
    }
    
    var emptyContent: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: __designTimeInteger("#27028_0", fallback: 13)) {
                Spacer()
                
                Image(__designTimeString("#27028_1", fallback: "Logo_sin_casa"))
                    .resizable()
                    .frame(width: __designTimeInteger("#27028_2", fallback: 200), height: __designTimeInteger("#27028_3", fallback: 150))
                
                Text(.noEstateCreated)
                    .font(.system(size: __designTimeInteger("#27028_4", fallback: 18), weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink(value: Destination.createEstate(id: nil),
                               label: {
                    HStack {
                        Image(systemName: __designTimeString("#27028_5", fallback: "hammer"))
                            .renderingMode(.template)
                            .tint(Color(__designTimeString("#27028_6", fallback: "light_green_button")))
                        Text(.createFirstEstate)
                            .font(.system(size: __designTimeInteger("#27028_7", fallback: 16), weight: .bold, design: .rounded))
                            .foregroundStyle(Color(__designTimeString("#27028_8", fallback: "light_green_button")))
                    }
                    .padding(__designTimeInteger("#27028_9", fallback: 15))
                    .frame(height: __designTimeFloat("#27028_10", fallback: 40.0))
                    .background {
                        RoundedRectangle(cornerRadius: __designTimeFloat("#27028_11", fallback: 20.0))
                            .fill(Color(__designTimeString("#27028_12", fallback: "dark_green_button")))
                    }
                })
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
                .swipeActions(edge: .trailing, allowsFullSwipe: __designTimeBoolean("#27028_13", fallback: false)) {
                    Button {
                        DispatchQueue.main.async {
                            router.navigateTo(route: .createEstate(id: estate.id.uuidString))
                        }
                    } label: {
                        Label(.edit, systemImage: __designTimeString("#27028_14", fallback: "pencil"))
                            .imageScale(.large)
                    }
                    .tint(.green)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.horizontal, __designTimeInteger("#27028_15", fallback: 10))
        .padding(.top, __designTimeInteger("#27028_16", fallback: 20))
        .navigationTitle(.myEstates)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.navigateTo(route: Destination.createEstate(id: nil))
                } label: {
                    Image(systemName: __designTimeString("#27028_17", fallback: "plus.circle"))
                    .foregroundColor(.white)
                }
            }
        }
        .background(.black)
    }
    
    @ViewBuilder
    private func estateView(estate: Estate) -> some View {
        HStack(spacing: __designTimeInteger("#27028_18", fallback: 20)) {
            Image(systemName: __designTimeString("#27028_19", fallback: "house"))
                .resizable()
                .frame(width: __designTimeInteger("#27028_20", fallback: 30), height: __designTimeInteger("#27028_21", fallback: 30))
                .tint(.white)
            
            VStack (alignment: .leading) {
                Text(estate.name)
                    .font(.system(size: __designTimeInteger("#27028_22", fallback: 16), weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(estate.address)
                    .font(.system(size: __designTimeInteger("#27028_23", fallback: 14), weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, __designTimeInteger("#27028_24", fallback: 15))
        .padding(.vertical, __designTimeInteger("#27028_25", fallback: 10))
        .background {
            RoundedRectangle(cornerRadius: __designTimeInteger("#27028_26", fallback: 10))
                .fill(.darkGrayBackground)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: EstateModel.self, configurations: config)
    let inmueble1 = EstateModel()
    inmueble1.name = __designTimeString("#27028_27", fallback: "Primavera")
    inmueble1.address = __designTimeString("#27028_28", fallback: "Carrera 50 # 3-34")
    
    let inmueble2 = EstateModel()
    inmueble2.name = __designTimeString("#27028_29", fallback: "Colonia Oriental")
    inmueble2.address = __designTimeString("#27028_30", fallback: "Calle 4Bis # 51A - 13")
    
    container.mainContext.insert(inmueble1)
    container.mainContext.insert(inmueble2)
    
    return ContentView()
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
