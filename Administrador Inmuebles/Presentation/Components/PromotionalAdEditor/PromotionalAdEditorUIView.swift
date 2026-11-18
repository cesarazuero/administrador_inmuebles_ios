//
//  PromotionalAdEditorUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 16/11/26.
//

import SwiftUI
import PhotosUI
import AVKit

struct PromotionalAdEditorUIView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var viewModel: PromotionalAdEditorViewModel
    
    @State private var adTextBuffer: String = ""
    @State private var photoDetailUrl: URL?
    @State private var showPhotoDetail = false
    @State private var showPhotosPicker = false
    @State private var showVideosPicker = false
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: --------------- AD TEXT ---------------------------
                Section {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $adTextBuffer)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .frame(height: 180)
                        
                        if adTextBuffer.isEmpty {
                            Text("ad_text_placeholder")
                                .foregroundColor(.secondary.opacity(0.7))
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .padding(.top, 10)
                                .padding(.leading, 6)
                                .allowsHitTesting(false)
                        }
                    }
                    .onChange(of: adTextBuffer) { _, new in
                        let limited = String(new.prefix(PromotionalAdEditorViewModel.MAX_AD_TEXT_CHARS))
                        
                        if limited != new { adTextBuffer = limited }
                        
                        viewModel.updateText(limited)
                    }
                } header: {
                    HeaderTextUIView(text: "ad_text")
                }
                // MARK: --------------- AD PHOTOS ---------------------------
                Section {
                    HStack(spacing: 25) {
                        Text("\(viewModel.adPhotoURLs.count)/\(PromotionalAdEditorViewModel.MIN_AD_PHOTOS)+")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundStyle(viewModel.adPhotoURLs.count >= PromotionalAdEditorViewModel.MIN_AD_PHOTOS ? .green : .orange)
                        
                        Spacer()
                        
                        Button {
                            viewModel.showAdCamera = true
                        } label: {
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderless)
                        .disabled(!viewModel.canAddMorePhotos)
                        
                        Button {
                            showPhotosPicker = true
                        } label: {
                            Image(systemName: "photo.on.rectangle.angled")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderless)
                        .disabled(!viewModel.canAddMorePhotos)
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.adPhotoURLs, id: \.self) { url in
                            if let uiImage = UIImage(contentsOfFile: url.path) {
                                Button {
                                    photoDetailUrl = url
                                    showPhotoDetail = true
                                } label: {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 65, height: 80)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                } header: {
                    HeaderTextUIView(text: .photos)
                } footer: {
                    Text("ad_photos_hint \(PromotionalAdEditorViewModel.MIN_AD_PHOTOS) \(PromotionalAdEditorViewModel.MAX_AD_PHOTOS)")
                }
                // MARK: --------------- AD VIDEO (OPTIONAL) ---------------------------
                Section {
                    if let videoURL = viewModel.adVideoURL {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Button(role: .destructive) {
                            viewModel.removeAdVideo()
                        } label: {
                            Label("ad_remove_video", systemImage: "trash")
                        }
                    } else {
                        Button {
                            showVideosPicker = true
                        } label: {
                            Label("ad_add_video", systemImage: "video.badge.plus")
                        }
                    }
                } header: {
                    HeaderTextUIView(text: "ad_video")
                }
            }
            .navigationTitle("ad_title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(.save,
                           systemImage: "checkmark",
                           role: .confirm,
                           action: {
                                dismiss()
                    })
                }
            }
        }
        .onAppear {
            adTextBuffer = viewModel.adText
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .photosPicker(isPresented: $showPhotosPicker,
                      selection: $viewModel.photoSelection,
                      maxSelectionCount: max(1, PromotionalAdEditorViewModel.MAX_AD_PHOTOS - viewModel.adPhotoURLs.count),
                      matching: .images)
        .photosPicker(isPresented: $showVideosPicker,
                      selection: $viewModel.videoSelection,
                      matching: .videos)
        .onChange(of: viewModel.photoSelection) {
            Task { await viewModel.loadAdPhotos() }
        }
        .onChange(of: viewModel.videoSelection) {
            Task { await viewModel.loadAdVideo() }
        }
        .onChange(of: viewModel.capturedAdImageURL) { _, new in
            if let new { viewModel.addAdPhoto(url: new) }
        }
        .fullScreenCover(isPresented: $viewModel.showAdCamera) {
            ImagePicker(sourceType: .camera, imageURL: $viewModel.capturedAdImageURL)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showPhotoDetail) {
            if let photo = photoDetailUrl {
                PhotoDetailUIView(photoUrl: photo,
                                  onDelete: { viewModel.removeAdPhoto(url: photo) })
                    .ignoresSafeArea()
            }
        }
    }
}
