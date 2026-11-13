//
//  CreateTenantViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 9/10/26.
//
import SwiftUI

@Observable
class CreateTenantViewModel {
    var estate: Estate
    var tenant = Tenant()
    var showAlert: Bool = false
    var messageAlert: String = ""
    var titleAlert: String = ""
    var btnDoneRole: ButtonRole? = nil
    var huId: String?
    
    init(estate: Estate, huId: String?) {
        self.estate = estate
        self.huId = huId
        
        if huId == nil,
           let existentTenant = estate.habitationalUnits?.last?.tenant {
            tenant = existentTenant
        } else if let huId = huId,
                  let hu = estate.habitationalUnits?.first(where: { $0.id.uuidString == huId }),
                  let tenantEdit = hu.tenant {
            tenant = tenantEdit
            checkFormStatus()
        }
    }
    
    func saveTenant() -> Bool {
        if tenant.name.isEmpty || tenant.identification.isEmpty {
            titleAlert = String(localized: "data_missing_title")
            messageAlert = String(localized: "data_missing_message")
            showAlert = true
            
            return false
        }
        
        if huId == nil,
            estate.habitationalUnits?.last != nil {
            estate.habitationalUnits?.last?.tenant = tenant
        } else if let hu = estate.habitationalUnits?.first(where: { $0.id.uuidString == huId }) {
            hu.tenant = tenant
        }
        
        return true
    }
    
    func checkFormStatus() {
        let pass = (!tenant.name.isEmpty && !tenant.identification.isEmpty && tenant.phoneNumber != nil && isValidEmail(tenant.email))
        btnDoneRole = pass ? .confirm : nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$/
        return email.wholeMatch(of: emailRegex) != nil
    }
}
