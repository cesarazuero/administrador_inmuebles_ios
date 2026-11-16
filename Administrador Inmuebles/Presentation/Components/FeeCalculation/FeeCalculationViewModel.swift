//
//  FeeCalculationViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 13/11/26.
//
import SwiftUI

@Observable
final class FeeCalculationViewModel {
    var service: PublicServices = .energy
    var readingAmount: Double = 0.0
    var price: String = ""
    var presentFeeSheet = false
    var presentShareSheet = false
    var total: Double? {
        guard let parsedPrice else { return nil }
        
        return parsedPrice * readingAmount
    }
    var stringToShare: String {
        guard let total = total else { return "" }
        
        return String(format: NSLocalizedString("message_consumption_share", comment: ""), service.localized, total.formatted(.currency(code: "COP")))
    }
    
    init() { }
    
    private var parsedPrice: Double? {
        Double(price.replacingOccurrences(of: ",", with: "."))
    }
    
    func setReadingAmount(amount: Double) {
        readingAmount = amount
    }
    
    func clearAll() {
        readingAmount = 0.0
        price = ""
    }
}
