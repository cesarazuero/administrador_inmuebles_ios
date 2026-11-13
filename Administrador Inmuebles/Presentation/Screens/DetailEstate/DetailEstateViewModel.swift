//
//  DetailEstateViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 22/10/26.
//
import SwiftUI

@Observable
class DetailEstateViewModel {
    private(set) var estate: Estate
    var presentRegisterDamageSheet = false
    var presentRegisterPaymentSheet = false
    var damageViewModel: RecordDamageViewModel?
    var paymentViewModel: RecordPaymentViewModel?
    private let router: Router
    
    init(estate: Estate, router: Router) {
        self.estate = estate
        self.router = router
    }
    
    func presentDamageSheet(huId: String) {
        let sheetBinding = Binding(
                    get: { self.presentRegisterDamageSheet },
                    set: { self.presentRegisterDamageSheet = $0 })
        
        damageViewModel = DependencyContainer.shared.createRecordDamageViewModel(huId: huId,
                                                                                 sheetPresented: sheetBinding,
                                                                                 damageModel: nil)
        presentRegisterDamageSheet = true
    }
    
    func presentPaymentSheet(huId: String) {
        let paymentBinding = Binding(
                    get: { self.presentRegisterPaymentSheet },
                    set: { self.presentRegisterPaymentSheet = $0 })
        
        paymentViewModel = DependencyContainer.shared.createRecordPaymentViewModel(huId: huId,
                                                                                   sheetPresented: paymentBinding,
                                                                                   paymentModel: nil)
        presentRegisterPaymentSheet = true
    }
    
    func goToDetailHabitationalUnit(huId: String) {
        router.navigateTo(route: .detailHabitationalUnit(huId: huId))
    }
}
