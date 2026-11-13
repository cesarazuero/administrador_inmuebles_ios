import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/PhotoDetailUIView.swift", line: 1)
//
//  PhotoDetailUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 28/10/26.
//

import SwiftUI

struct PhotoDetailUIView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var photoUrl: URL
    @State var presentShare = false
    @State var askDeleteImage = false
    
    let onDelete: () -> Void
    
    var body: some View {
        if let uiImage = UIImage(contentsOfFile: photoUrl.path) {
            NavigationStack {
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: __designTimeInteger("#3349_0", fallback: 10)))
                        .overlay(
                            RoundedRectangle(cornerRadius: __designTimeInteger("#3349_1", fallback: 12))
                                .stroke(Color.gray.opacity(__designTimeFloat("#3349_2", fallback: 0.3)), lineWidth: __designTimeInteger("#3349_3", fallback: 1))
                        )
                        .toolbar {
                            
                        }
                    
                    Spacer()
                }
                .padding(__designTimeInteger("#3349_4", fallback: 10))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: __designTimeString("#3349_5", fallback: "xmark"))
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: __designTimeInteger("#3349_6", fallback: 20)) {
                        Button {
                            presentShare = __designTimeBoolean("#3349_7", fallback: true)
                        } label: {
                            Image(systemName: __designTimeString("#3349_8", fallback: "square.and.arrow.up"))
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            askDeleteImage = __designTimeBoolean("#3349_9", fallback: true)
                        } label: {
                            Image(systemName: __designTimeString("#3349_10", fallback: "trash"))
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal, __designTimeInteger("#3349_11", fallback: 1))
                }
            }
            .sheet(isPresented: $presentShare) {
                ActivityView(activityItems: [photoUrl])
            }
            .confirmationDialog(.deletePhoto, isPresented: $askDeleteImage) {
                Button(.eliminate, role: .destructive) {
                    onDelete()
                    dismiss()
                }
                
                Button(.cancel, role: .cancel) {
                    askDeleteImage = __designTimeBoolean("#3349_12", fallback: false)
                }
            } message: {
                Text(.messageDeletePhoto)
                    .foregroundStyle(.white)
                    .font(.system(size: __designTimeInteger("#3349_13", fallback: 16), weight: .bold, design: .rounded))
            }
        }
    }
}

#Preview {
    func createMockImagefile(named fileName: String, systemSymbol: String) -> URL {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        if let uiImage = UIImage(systemName: systemSymbol)?
            .withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
           let data = uiImage.jpegData(compressionQuality: __designTimeFloat("#3349_14", fallback: 0.8)) {
            try? data.write(to: url)
        }
        return url
    }
    
    let photoUrl = createMockImagefile(named: "p1.jpg", systemSymbol: "exclamationmark.triangle")
    
    return NavigationStack {
        PhotoDetailUIView(photoUrl: photoUrl) {}
            .preferredColorScheme(.dark)
    }
}
