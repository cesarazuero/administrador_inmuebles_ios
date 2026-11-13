//
//  PhoneCall.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 10/11/26.
//
import Foundation
import UIKit

@Observable
final class PhoneCall {
    var showPhoneCallAlert = false
    let messageAlert = String(localized: "message_error_calling")
    let titleAlert = String(localized: "title_error_calling")
    
    init() { }
    
    func call(number: Int?) {
        guard let number = number else { return }
        
        let cleaned = String(number).filter { $0.isNumber || $0 == "+" }
        
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        
        UIApplication.shared.open(url) { [weak self] isAble in
            guard let self = self else { return }
            
            self.showPhoneCallAlert = !isAble
        }
    }
}
