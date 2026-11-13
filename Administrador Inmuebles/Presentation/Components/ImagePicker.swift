//
//  ImagePicker.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 27/10/26.
//
import SwiftUI
import UIKit
import Photos

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var imageURL: URL?
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                if let url = saveImageLocally(image) {
                    parent.imageURL = url
                }
                
                if picker.sourceType == .camera {
                    saveImageToSystemPhotos(image)
                }
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }

        private func saveImageLocally(_ image: UIImage) -> URL? {
            guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
            
            let fileName = UUID().uuidString + ".jpg"
            let fileURL = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask)[0].appendingPathComponent(fileName)
            
            do {
                try data.write(to: fileURL)
                return fileURL
            } catch {
                print("Error al guardar la imagen en disco: \(error)")
                return nil
            }
        }
        
        private func saveImageToSystemPhotos(_ image: UIImage) {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                guard status == .authorized || status == .limited else {
                    print("Permiso de galería denegado por el usuario.")
                    return
                }
                
                PHPhotoLibrary.shared().performChanges({
                    // Crea una solicitud para agregar la imagen a la fototeca
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { success, error in
                    if success {
                        print("Foto guardada exitosamente en la librería del sistema.")
                    } else if let error = error {
                        print("Error al guardar en la librería: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
