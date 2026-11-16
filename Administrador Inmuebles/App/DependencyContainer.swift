//
//  DependencyContainer.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 20/10/26.
//
import SwiftData
import Foundation
import SwiftUI

final class DependencyContainer {
    static let shared = DependencyContainer()
    static let schema = Schema([EstateModel.self,
                                HabitationalUnitModel.self,
                                TenantModel.self,
                                DamageModel.self,
                                PaymentModel.self,
                                NotificationsModel.self,
                                MeterCaptureModel.self])
    
    private var estate = Estate()
    
    private lazy var sharedModelContainer: ModelContainer = {
        let modelConfiguration = ModelConfiguration(schema: DependencyContainer.schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: DependencyContainer.schema, configurations: [modelConfiguration])
            
            if let url = container.configurations.first?.url {
                print("📍 SwiftData DB Path: \(url.path)")
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    private lazy var estateMapper: EstateMapper = {
        EstateMapper()
    }()
    
    private lazy var estateRepository: EstateModelRepository = {
        EstateModelRepository(sharedModelContainer)
    }()
    
    private lazy var habitationalUnitRepository: HabitationalUnitModelRepository = {
        HabitationalUnitModelRepository(sharedModelContainer)
    }()
    
    private lazy var notificationsRepository: NotificationsRepository = {
       NotificationsRepository(modelContainer: sharedModelContainer)
    }()
    
    private lazy var meterCaptureRepository: MeterCaptureRepository = {
       MeterCaptureRepository(modelContainer: sharedModelContainer)
    }()
    
    private lazy var saveEstateUseCase: SaveEstateUseCase = {
       SaveEstateUseCase(modelContext: sharedModelContainer.mainContext,
                         estateRepository: estateRepository)
    }()
    
    private lazy var saveDamageUseCase: SaveDamageUseCase = {
        SaveDamageUseCase(modelContext: sharedModelContainer.mainContext,
                          habitationalUnitRepository: habitationalUnitRepository)
    }()
    
    private lazy var savePaymentUseCase: SavePaymentUseCase = {
        SavePaymentUseCase(modelContext: sharedModelContainer.mainContext,
                           habitationalUnitRepository: habitationalUnitRepository)
    }()
    
    private lazy var notificationsUseCase: NotificationsUseCase = {
        NotificationsUseCase(notificationsRepository: notificationsRepository)
    }()
    
    private lazy var saveMeterCaptureUseCase: SaveMeterCaptureUseCase = {
       SaveMeterCaptureUseCase(meterRepository: meterCaptureRepository)
    }()
    
    private lazy var router: Router = {
        let router = Router()
        router.screenFactory = { [unowned self] destination in
            self.makeScreen(for: destination)
        }
        
        return router
    }()
    
    
    // MARK: -------------- ViewModels ------------------------------
    func createEstateViewModel(id: String?) -> CreateEstateViewModel {
        return CreateEstateViewModel(estate: estate,
                                     id: id,
                                     saveEstateUseCase: saveEstateUseCase,
                                     estateRepository: estateRepository,
                                     router: router,
                                     notificationsUseCase: notificationsUseCase)
    }
    
    func createHabitationalUnitViewModel(id: String?) -> CreateHabitationalUnitViewModel {
        return CreateHabitationalUnitViewModel(estate: estate,
                                        id: id,
                                        router: router)
    }
    
    func createTenantViewModel(huId: String?) -> CreateTenantViewModel {
        CreateTenantViewModel(estate: estate,
                              huId: huId)
    }
    
    func createDetailEstateViewModel(estate: Estate) -> DetailEstateViewModel {
        DetailEstateViewModel(estate: estate,
                              router: router)
    }
    
    func createRecordDamageViewModel(huId: String, sheetPresented: Binding<Bool>, damageModel: DamageModel?) -> RecordDamageViewModel {
        RecordDamageViewModel(huId: huId,
                              sheetPresented: sheetPresented,
                              habitationalUnitRepository: habitationalUnitRepository,
                              saveDamageUseCase: saveDamageUseCase,
                              damageModel: damageModel)
    }
    
    func createRecordPaymentViewModel(huId: String, sheetPresented: Binding<Bool>, paymentModel: PaymentModel?) -> RecordPaymentViewModel {
        RecordPaymentViewModel(huId: huId,
                               sheetPresented: sheetPresented,
                               habitationalUnitRepository: habitationalUnitRepository,
                               savePaymentUseCase: savePaymentUseCase,
                               paymentModel: paymentModel)
    }
    
    func createDetailHabitationalUnitViewModel(huId: String) -> DetailHabitationalUnitViewModel {
        DetailHabitationalUnitViewModel(huId: huId,
                                        router: router,
                                        huRepository: habitationalUnitRepository)
    }
    
    func createSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(notificationsUseCase: notificationsUseCase)
    }
    
    func createMeterCaptureViewModel() -> MeterCaptureViewModel {
        MeterCaptureViewModel(saveMeterUseCase: saveMeterCaptureUseCase)
    }
    
    func createFeeCalculationViewModel() -> FeeCalculationViewModel {
        FeeCalculationViewModel()
    }
    // MARK: -------------- ESTATE MODIFIERS ------------------------------
    func clearEstate() {
        estate = Estate()
    }
    
    func updateEstate(id: String) {
        if let fetchedEstate = fetchEstate(id: id) {
            self.estate = fetchedEstate
        }
    }
    // MARK: -------------- GET Methods ------------------------------
    func getModelContainer() -> ModelContainer {
        sharedModelContainer
    }
    
    func getEstateModelRepository() -> EstateRepositoryProtocol {
        estateRepository
    }
    
    func getHabitationalUnitModelRepository() -> HabitationalUnitModelRepository {
        habitationalUnitRepository
    }
    
    func getDamagesRepository() -> DamageModelRepository {
        DamageModelRepository()
    }
    
    func getPaymentsRepository() -> PaymentModelRepository {
        PaymentModelRepository()
    }
    
    func getRouter() -> Router {
        router
    }
    
    private func fetchEstate(id: String) -> Estate? {
        guard let fetchedEstate = estateRepository.getStateById(id: id) else { return nil }
        return fetchedEstate
    }
    
    private func makeScreen(for destination: Destination) -> Screen {
        switch destination {
        case .createEstate(let id):
            Screen(kind: .createEstate(createEstateViewModel(id: id)))
        case .createHabitationalUnit(let id):
            Screen(kind: .createHabitationalUnit(createHabitationalUnitViewModel(id: id)))
        case .createTenant(let huId):
            Screen(kind: .createTenant(createTenantViewModel(huId: huId)))
        case .detailEstate(let estate):
            Screen(kind: .detailEstate(createDetailEstateViewModel(estate: estate),
                                       createMeterCaptureViewModel()))
        case .detailHabitationalUnit(let huId):
            Screen(kind: .detailHabitationalUnit(huId: huId,
                                                 viewModel: createDetailHabitationalUnitViewModel(huId: huId),
                                                 meterCaptureViewModel: createMeterCaptureViewModel(),
                                                 feeCalculationViewModel: createFeeCalculationViewModel()))
        case .settings:
            Screen(kind: .settings(createSettingsViewModel()))
        }
    }
}
