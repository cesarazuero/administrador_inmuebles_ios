//
//  PromotionalAdEditorViewModel.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 17/11/26.
//
import SwiftUI
import PhotosUI

@Observable
class PromotionalAdEditorViewModel {
    let habitationalUnit: HabitationalUnit
    var showAdCamera: Bool = false
    var capturedAdImageURL: URL?
    var photoSelection: [PhotosPickerItem] = []
    var videoSelection: PhotosPickerItem?
    var showAlert: Bool = false
    private(set) var messageAlert: String = ""
    private(set) var titleAlert: String = ""
    
    /// Called whenever the ad content changes so the owner can refresh its form status.
    var onChange: (() -> Void)?
    
    static let MIN_AD_PHOTOS = 5
    static let MAX_AD_PHOTOS = 15
    static let MAX_AD_TEXT_CHARS = 1000
    
    /// Ad files created during this editing session; deleted if the user leaves without saving.
    private var sessionFiles: Set<String> = []
    
    init(huId: String?,
         estate: Estate,
         habitationalUnit: HabitationalUnit = HabitationalUnit()) {
        let unit: HabitationalUnit
        
        if let id = huId, let uuId = UUID(uuidString: id), let hu = estate.habitationalUnits?.first(where: { $0.id == uuId }) {
            unit = hu
        } else {
            unit = habitationalUnit
        }
        
        self.habitationalUnit = unit
    }
    
    private static var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var adText: String {
        habitationalUnit.adText ?? ""
    }
    
    /// The ad is optional, but once the user starts it, it must be complete.
    var hasAd: Bool {
        !adText.isEmpty
        || !adPhotoURLs.isEmpty
        || habitationalUnit.adVideoFileName != nil
    }
    
    var isAdValid: Bool {
        !adText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && adPhotoURLs.count >= Self.MIN_AD_PHOTOS
    }
    
    var adPhotoURLs: [URL] {
        (habitationalUnit.adPhotoFileNames ?? []).map {
            Self.documentsURL.appendingPathComponent($0)
        }
    }
    
    var adVideoURL: URL? {
        habitationalUnit.adVideoFileName.map {
            Self.documentsURL.appendingPathComponent($0)
        }
    }
    
    var canAddMorePhotos: Bool {
        adPhotoURLs.count < Self.MAX_AD_PHOTOS
    }
    
    func updateText(_ text: String) {
        habitationalUnit.adText = text
        onChange?()
    }
    
    func addAdPhoto(url: URL) {
        guard canAddMorePhotos else {
            try? FileManager.default.removeItem(at: url)
            return
        }
        
        habitationalUnit.adPhotoFileNames = (habitationalUnit.adPhotoFileNames ?? []) + [url.lastPathComponent]
        sessionFiles.insert(url.lastPathComponent)
        onChange?()
    }
    
    func removeAdPhoto(url: URL) {
        try? FileManager.default.removeItem(at: url)
        sessionFiles.remove(url.lastPathComponent)
        habitationalUnit.adPhotoFileNames?.removeAll { $0 == url.lastPathComponent }
        onChange?()
    }
    
    func removeAdVideo() {
        if let url = adVideoURL {
            try? FileManager.default.removeItem(at: url)
            sessionFiles.remove(url.lastPathComponent)
        }
        habitationalUnit.adVideoFileName = nil
        onChange?()
    }
    
    func loadAdPhotos() async {
        let items = photoSelection
        photoSelection = []
        
        for item in items {
            guard canAddMorePhotos else { break }
            
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data),
               let jpeg = image.jpegData(compressionQuality: 0.8) {
                let url = Self.documentsURL.appendingPathComponent(UUID().uuidString + ".jpg")
                
                do {
                    try jpeg.write(to: url)
                    addAdPhoto(url: url)
                } catch {
                    showError(error)
                }
            }
        }
    }
    
    func loadAdVideo() async {
        guard let item = videoSelection else { return }
        videoSelection = nil
        
        do {
            guard let movie = try await item.loadTransferable(type: AdMovie.self) else { return }
            removeAdVideo()
            habitationalUnit.adVideoFileName = movie.url.lastPathComponent
            sessionFiles.insert(movie.url.lastPathComponent)
            onChange?()
        } catch {
            showError(error)
        }
    }
    
    /// Keeps the files added in this session (the unit was saved).
    func commitSessionFiles() {
        sessionFiles.removeAll()
    }
    
    /// Deletes the files added in this session and drops their references from the unit.
    func discardSessionFiles() {
        for name in sessionFiles {
            try? FileManager.default.removeItem(at: Self.documentsURL.appendingPathComponent(name))
        }
        
        habitationalUnit.adPhotoFileNames?.removeAll { sessionFiles.contains($0) }
        
        if let video = habitationalUnit.adVideoFileName, sessionFiles.contains(video) {
            habitationalUnit.adVideoFileName = nil
        }
        
        sessionFiles.removeAll()
    }
    
    private func showError(_ error: Error) {
        titleAlert = String(localized: .error)
        messageAlert = error.localizedDescription
        showAlert = true
    }
}

/// Video picked from the library, copied into the documents directory.
struct AdMovie: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let ext = received.file.pathExtension.isEmpty ? "mov" : received.file.pathExtension
            let destination = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(UUID().uuidString + "." + ext)
            try FileManager.default.copyItem(at: received.file, to: destination)
            return AdMovie(url: destination)
        }
    }
}
