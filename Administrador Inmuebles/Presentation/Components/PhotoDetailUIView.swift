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
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .toolbar {
                            
                        }
                    
                    Spacer()
                }
                .padding(10)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        Button {
                            presentShare = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            askDeleteImage = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal, 10)
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
                    askDeleteImage = false
                }
            } message: {
                Text(.messageDeletePhoto)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
        }
    }
}

#Preview {
    func createMockImagefile(named fileName: String, systemSymbol: String) -> URL {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        if let uiImage = UIImage(systemName: systemSymbol)?
            .withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
           let data = uiImage.jpegData(compressionQuality: 0.8) {
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
