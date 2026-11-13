//
//  RecordPaymentViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 29/10/26.
//
import SwiftUI

@Observable
class RecordPaymentViewModel {
    var amount: Double?
    var names: [String] = []
    var pickerValueSelected: String
    var issuerTyped: String = ""
    var btnDoneRole: ButtonRole? = nil
    var otherFieldDisabled = true
    var sheetPresented: Binding<Bool>
    var showAlert: Bool = false
    var bankNames: [String] = []
    var bankNameSelected: String = ""
    var createdAt: Date = Date()
    private let huId: String
    private(set) var messageAlert: String = ""
    private(set) var titleAlert: String = ""
    private var habitationalUnitRepository: HabitationalUnitRepositoryProtocol
    private var savePaymentUseCase: SavePaymentUseCaseProtocol
    private var paymentModelUnderEdit: PaymentModel?
    
    init(huId: String,
         sheetPresented: Binding<Bool>,
         habitationalUnitRepository: HabitationalUnitRepositoryProtocol,
         savePaymentUseCase: SavePaymentUseCaseProtocol,
         paymentModel: PaymentModel? = nil) {
        self.pickerValueSelected = ""
        self.huId = huId
        self.sheetPresented = sheetPresented
        self.habitationalUnitRepository = habitationalUnitRepository
        self.savePaymentUseCase = savePaymentUseCase
        self.bankNames = getBankNames() ?? []
        
        let tenant = getTenant()
        
        self.names.append(tenant?.name ?? "")
        self.names.append(String(localized: "other"))
        
        self.pickerValueSelected = tenant?.name ?? String(localized: "other")
        
        if let model = paymentModel {
            self.paymentModelUnderEdit = model
            self.amount = model.amount
            self.createdAt = model.payment_date
            self.bankNameSelected = model.bank
            
            if model.made_by != tenant?.name {
                self.otherFieldDisabled = false
                self.issuerTyped = model.made_by ?? ""
                self.pickerValueSelected = String(localized: "other")
            } else {
                self.otherFieldDisabled = true
                self.pickerValueSelected = model.made_by ?? ""
            }
        }
    }
    
    private func getTenant() -> Tenant? {
        guard let fetchedHu = habitationalUnitRepository.getHabitationalUnitById(id: huId)
        else { return nil }
        
        return fetchedHu.tenant
    }
    
    private func getBankNames() -> [String]? {
        guard let array = LoadLocalJSONService.loadJSON(filename: "ListaBancos", as: [Bank].self)
                else { return nil }
        
        return array.map { $0.name }.sorted(by: <)
    }
    
    func checkStatus() {
        let defaultCondition = amount != nil && amount != 0.0 && otherFieldDisabled && !bankNameSelected.isEmpty
        let reportedByOther = amount != nil && amount != 0.0 && !otherFieldDisabled && !issuerTyped.isEmpty && !bankNameSelected.isEmpty
        
        btnDoneRole = defaultCondition || reportedByOther ? .confirm : nil
    }
    
    func savePayment() -> Bool {
        let issuer = !otherFieldDisabled ? issuerTyped : pickerValueSelected
            
        do {
            let paymentModel = Payment(id: paymentModelUnderEdit?.id ?? UUID(),
                                       created_at: Date(),
                                       payment_date: createdAt,
                                       amount: amount ?? 0.0,
                                       made_by: issuer,
                                       bank: bankNameSelected)
            
            try savePaymentUseCase.execute(payment: paymentModel,
                                           habitationalUnitId: huId)
            
            return true
        } catch {
            titleAlert = String(localized: "error")
            messageAlert = "\(String(localized: "error_saving_estate"))\n\(String(localized: "please_try_again"))"
            showAlert = true
            
            return false
        }
    }
}
