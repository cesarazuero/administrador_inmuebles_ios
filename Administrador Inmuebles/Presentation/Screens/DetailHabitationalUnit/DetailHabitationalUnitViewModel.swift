//
//  DetailHabitationalUnitViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 3/11/26.
//
import SwiftUI

@Observable
class DetailHabitationalUnitViewModel {
    let huId: String
    let router: Router
    
    var damageViewModel: RecordDamageViewModel?
    var paymentViewModel: RecordPaymentViewModel?
    var presentRegisterDamageSheet = false
    var presentRegisterPaymentSheet = false
    var presentPDFViewer = false
    var habitationalUnitRepository: HabitationalUnitRepositoryProtocol
    var phoneNumberTenant: Int?
    var emailTenant: String?
    var shareUrl: URL?
    var data: Data?
    var pdfName: String?
    var showAlert = false
    var titleAlert: String = ""
    var messageAlert: String = ""
    
    init (huId: String, router: Router, huRepository: HabitationalUnitRepositoryProtocol) {
        self.huId = huId
        self.router = router
        self.habitationalUnitRepository = huRepository
        
        if let hu = habitationalUnitRepository.getHabitationalUnitById(id: huId),
            let phoneNumber = hu.tenant?.phoneNumber,
            let email = hu.tenant?.email {
            phoneNumberTenant = phoneNumber
            emailTenant = email
            
            if let pdfName = hu.documentPDFName, let data = hu.documentPDF {
                self.data = data
                self.shareUrl = makeShareURL(pdfName: pdfName, data: data)
                self.pdfName = pdfName
            }
        }
    }
    
    func goBack() {
        router.goBack()
    }    
    
    func presentDamageSheet(_ damageModel: DamageModel? = nil) {
        let sheetBinding = Binding(
                    get: { self.presentRegisterDamageSheet },
                    set: { self.presentRegisterDamageSheet = $0 })
        
        damageViewModel = DependencyContainer.shared.createRecordDamageViewModel(huId: huId,
                                                                                 sheetPresented: sheetBinding,
                                                                                 damageModel: damageModel)
        presentRegisterDamageSheet = true
    }
    
    func presentPaymentSheet(_ paymentModel: PaymentModel? = nil) {
        let paymentBinding = Binding(
                    get: { self.presentRegisterPaymentSheet },
                    set: { self.presentRegisterPaymentSheet = $0 })
        
        paymentViewModel = DependencyContainer.shared.createRecordPaymentViewModel(huId: huId,
                                                                                   sheetPresented: paymentBinding,
                                                                                   paymentModel: paymentModel)
        presentRegisterPaymentSheet = true
    }
    
    private func makeShareURL(pdfName: String, data: Data) -> URL? {
        var fileName = pdfName
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: " ", with: "_")

        if fileName.isEmpty {
            fileName = "documento"
        }

        if !fileName.lowercased().hasSuffix(".pdf") {
            fileName += ".pdf"
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try data.write(to: url)
            return url
        } catch {
            return nil
        }
    }
    
    func calculateFee(meters: [MeterCaptureModel], publicService: PublicServices) {
        let measures = meters.filter { $0.type == publicService }.sorted(by: { $0.date < $1.date})
        
        if measures.isEmpty || measures.count < 2 {
            titleAlert = String(localized: "error")
            messageAlert = String(localized: "calculate_fee_error_meters_not_enough")
            showAlert = true
            
            return
        }
        
        let lastMeasure = measures[measures.count - 1]
        let penultimate = measures[measures.count - 2]
        let readingAmount = lastMeasure.measure - penultimate.measure
    }
}
