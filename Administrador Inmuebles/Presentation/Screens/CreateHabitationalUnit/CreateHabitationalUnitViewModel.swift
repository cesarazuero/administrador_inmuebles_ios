//
//  CreateHabitationalUnitViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 8/10/26.
//
import SwiftUI
internal import Combine

@Observable
class CreateHabitationalUnitViewModel {
    var estate: Estate
    var habitationalUnit: HabitationalUnit
    var btnDoneRole: ButtonRole? = nil
    var id: String?
    var showAlert: Bool = false
    var showFileImporter: Bool = false
    var messageAlert: String = ""
    var titleAlert: String = ""
    
    var showAdEditor: Bool = false
    var hasAd: Bool { adEditorViewModel.hasAd }
    var isAdValid: Bool { adEditorViewModel.isAdValid }
    
    let adEditorViewModel: PromotionalAdEditorViewModel
    let router: Router
    
    init(estate: Estate,
         habitationalUnit: HabitationalUnit = HabitationalUnit(),
         id: String?,
         router: Router,
         adEditorViewModel: PromotionalAdEditorViewModel) {
        self.estate = estate
        self.router = router
        self.id = id
        
        let unit: HabitationalUnit
        
        if let id = id, let uuId = UUID(uuidString: id), let hu = estate.habitationalUnits?.first(where: { $0.id == uuId }) {
            unit = hu
        } else {
            unit = habitationalUnit
        }
        
        self.habitationalUnit = unit
        self.adEditorViewModel = adEditorViewModel
        //self.adEditorViewModel = PromotionalAdEditorViewModel(habitationalUnit: unit)
        self.adEditorViewModel.onChange = { [weak self] in
            self?.checkFormStatus()
        }
    }
    
    func getTenant() -> Tenant {
        guard let tenant = habitationalUnit.tenant else {
            return Tenant()
        }
        
        return tenant
    }
    
    func checkFormStatus() {
        let pass = estate.habitationalUnits?.last?.tenant != nil && !habitationalUnit.name.isEmpty && habitationalUnit.rentAmount != nil && (!hasAd || isAdValid)
        btnDoneRole = pass ? .confirm : nil
    }
    
    func attachDocument(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            let hasAccess = url.startAccessingSecurityScopedResource()
            
            defer {
                if hasAccess { url.stopAccessingSecurityScopedResource() }
            }

            do {
                habitationalUnit.documentPDF = try Data(contentsOf: url)
                habitationalUnit.documentPDFName = url.lastPathComponent
            } catch {
                titleAlert = String(localized: .error)
                messageAlert = error.localizedDescription
                showAlert = true
            }
        case .failure(let error):
            titleAlert = String(localized: .error)
            messageAlert = error.localizedDescription
            showAlert = true
        }
    }

    func removeDocument() {
        habitationalUnit.documentPDF = nil
        habitationalUnit.documentPDFName = nil
    }

    func goToCreateTenant() {
        addDraft()
        router.navigateTo(route: Destination.createTenant(huId: id))
    }
    
    func saveHabitationalUnit() {
        adEditorViewModel.commitSessionFiles()
        addDraft()
        router.goBack()
    }
    
    private func addDraft() {
        if self.estate.habitationalUnits == nil {
            self.estate.habitationalUnits = []
        }
        
        guard let hus = self.estate.habitationalUnits,
              !hus.contains(self.habitationalUnit)
               else { return }
        
        self.estate.habitationalUnits?.append(self.habitationalUnit)
    }
    
    func goBack() {
        adEditorViewModel.discardSessionFiles()
        
        if estate.habitationalUnits?.last?.name == "" && estate.habitationalUnits?.last?.tenant == nil {
            estate.habitationalUnits?.removeLast()
        }
        
        router.goBack()
    }
}
