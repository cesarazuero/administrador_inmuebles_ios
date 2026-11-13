//
//  RecordDamageViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//
import SwiftUI
internal import Combine

@Observable
class RecordDamageViewModel {
    private var huId: String
    var damage: String
    var created_at: Date
    var issuer: String
    var tenant: Tenant?
    private var saveDamageUseCase: SaveDamageUseCaseProtocol
    private var habitationalUnitRepository: HabitationalUnitRepositoryProtocol
    var names: [String] = []
    var pickerValueSelected: String
    var issuerTyped: String = ""
    var sheetPresented: Binding<Bool>
    var btnDoneRole: ButtonRole? = nil
    var otherFieldDisabled = true
    var showAlert: Bool = false
    private(set) var messageAlert: String = ""
    private(set) var titleAlert: String = ""
    var capturedImageURL: URL?
    var showCamera = false
    var photosUrlArray: [URL] = []
    var photoDetailUrl: URL?
    var showPhotoDetail = false
    var photoType: UIImagePickerController.SourceType = .camera
    var damageBuffer: String = ""
    var reportedByBuffer: String = ""
    var stateSelected: DamageState = .created
    var damageModelUnderEdit: DamageModel?
    
    init(huId: String,
         damage: String = "",
         created_at: Date = Date(),
         issuer: String = "",
         sheetPresented: Binding<Bool>,
         habitationalUnitRepository: HabitationalUnitRepositoryProtocol,
         saveDamageUseCase: SaveDamageUseCaseProtocol,
         damageModel: DamageModel? = nil) {
        self.huId = huId
        self.damage = damage
        self.created_at = created_at
        self.issuer = issuer
        self._sheetPresented = sheetPresented
        self.habitationalUnitRepository = habitationalUnitRepository
        self.saveDamageUseCase = saveDamageUseCase
        self.pickerValueSelected = ""
        self.tenant = getTenant()
        
        self.names.append(tenant?.name ?? "")
        self.names.append(String(localized: "other"))
        
        self.pickerValueSelected = tenant?.name ?? String(localized: "other")
        
        if let model = damageModel {
            self.damageModelUnderEdit = model
            self.damage = model.damage
            self.created_at = model.created_at
            self.stateSelected = model.state
            
            if let paths = model.photoPaths {
                self.photosUrlArray = paths.compactMap {
                    if let last = URL(string: $0)?.lastPathComponent {
                        return FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
                                .appendingPathComponent(last)
                    } else {
                        return nil
                    }
                }
            }
            
            if model.issuer != tenant?.name {
                self.otherFieldDisabled = false
                self.issuerTyped = model.issuer ?? ""
                self.pickerValueSelected = String(localized: "other")
            } else {
                self.otherFieldDisabled = true
                self.pickerValueSelected = model.issuer ?? ""
            }
        }
    }
    
    private func getTenant() -> Tenant? {
        guard let fetchedHu = habitationalUnitRepository.getHabitationalUnitById(id: huId)
        else { return nil }
        
        return fetchedHu.tenant
    }
    
    func checkStatus() {
        let defaultCondition = !damage.isEmpty && otherFieldDisabled
        let reportedByOther = !damage.isEmpty && !otherFieldDisabled && !issuerTyped.isEmpty
        
        btnDoneRole = defaultCondition || reportedByOther ? .confirm : nil
    }
    
    func saveDamage() -> Bool {
        let issuer = !otherFieldDisabled ? issuerTyped : pickerValueSelected
            
        do {
            let damageModel = Damage(id: damageModelUnderEdit?.id ?? UUID(),
                                     damage: damage,
                                     created_at: created_at,
                                     state: stateSelected,
                                     issuer: issuer,
                                     photoPaths: photosUrlArray.map { $0.path() })
            
            try saveDamageUseCase.execute(damage: damageModel,
                                          habitationalUnitId: huId)
            
            return true
        } catch {
            titleAlert = String(localized: "error")
            messageAlert = "\(String(localized: "error_saving_estate"))\n\(String(localized: "please_try_again"))"
            showAlert = true
            
            return false
        }
    }
    
    func takePhoto() {
        photoType = .camera
        showCamera = true
    }
    
    func selectPhotoFromGallery() {
        photoType = .photoLibrary
        showCamera = true
    }
    
    func savePhoto(_ url: URL) {
        photosUrlArray.append(url)
    }
    
    func deletePhoto() {
        guard let photoToDelete = photoDetailUrl else { return }
        
        try? FileManager.default.removeItem(at: photoToDelete)
        
        withAnimation{
            if let index = photosUrlArray.firstIndex(of: photoToDelete) {
                photosUrlArray.remove(at: index)
            }
        }
    }
    
    func changeState(state: DamageState) {
        withAnimation {
            self.stateSelected = state
        }
    }
}
