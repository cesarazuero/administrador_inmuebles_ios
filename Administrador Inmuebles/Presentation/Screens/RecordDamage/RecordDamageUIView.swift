//
//  RecordDamageUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 23/10/26.
//
import SwiftUI
import SwiftData
internal import Combine

struct RecordDamageUIView: View {
    @State var viewModel: RecordDamageViewModel
    
    
    @FocusState private var focusedField: FocusedFields?
    
    static let MAX_DAMAGE_CHARS: Int = 500
    static let MAX_REPORTED_BY_CHARS: Int = 50
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    // MARK: --------------- DAMAGE TEXT ---------------------------
                    Section {
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $viewModel.damageBuffer)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .frame(height: 150)
                                .focused($focusedField, equals: .damage)
                            
                            if viewModel.damageBuffer.isEmpty {
                                Text(.damageDescription)
                                    .foregroundColor(.secondary.opacity(0.7))
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .padding(.top, 10)
                                    .padding(.leading, 6)
                                    .allowsHitTesting(false)
                            }
                        }
                        .onAppear {
                            viewModel.damageBuffer = viewModel.damage
                        }
                        .onChange(of: viewModel.damageBuffer) { old, new in
                            if new.count > RecordDamageUIView.MAX_DAMAGE_CHARS {
                                viewModel.damageBuffer = String(new.prefix(RecordDamageUIView.MAX_DAMAGE_CHARS))
                            } else {
                                viewModel.damage = viewModel.damageBuffer
                            }
                            
                            viewModel.checkStatus()
                        }
                    }
                    // MARK: --------------- DAMAGE DATE ---------------------------
                    Section {
                        HStack {
                            Text(.select)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            
                            Spacer()
                            
                            CustomCompactDatePickerUIView(selectedDate: $viewModel.created_at)
                        }
                    } header: {
                        HeaderTextUIView(text: .damageDate)
                    }
                    // MARK: --------------- DAMAGE REPORTER ---------------------------
                    Section {
                        SelectOrEnterNameUIView(pickerValueSelected: $viewModel.pickerValueSelected,
                                                issuerTyped: $viewModel.issuerTyped,
                                                otherFieldDisabled: $viewModel.otherFieldDisabled,
                                                names: viewModel.names,
                                                reportedByBuffer: viewModel.reportedByBuffer,
                                                maxChars: RecordDamageUIView.MAX_REPORTED_BY_CHARS,
                                                labelTextField: String(localized: "reported_by"))
                    } header: {
                        HeaderTextUIView(text: .reportedBy)
                    }
                    // MARK: --------------- DAMAGE STATUS  ---------------------------
                    if viewModel.damageModelUnderEdit != nil {
                        Section {
                            HStack(alignment: .top) {
                                ForEach(DamageState.allCases, id: \.self) { state in
                                    Button {
                                        viewModel.changeState(state: state)
                                    }
                                    label: {
                                        VStack {
                                            Circle()
                                                .fill(state.getColor())
                                                .frame(width: 15, height: 15)
                                                .shadow(color: state.getColor(),
                                                        radius: 10,
                                                        x: 0,
                                                        y: 0)
                                            Text(state.localizedName)
                                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                                .frame(maxWidth: .infinity,
                                                       maxHeight: .infinity,
                                                       alignment: .top)
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(.vertical, 10)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.white.opacity(viewModel.stateSelected == state ? 0.1 : 0.0))
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        } header: {
                            HeaderTextUIView(text: .status)
                        }
                    }
                    // MARK: --------------- DAMAGE PHOTOS ---------------------------
                    Section {
                        // MARK: --------------- TAKE PHOTOS CONTROLS ---------------------------
                        HStack(spacing: 25) {
                            Spacer()
                            
                            Button {
                                viewModel.takePhoto()
                                focusedField = nil
                            } label: {
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderless)
                            
                            Button {
                                viewModel.selectPhotoFromGallery()
                                focusedField = nil
                            } label: {
                                Image(systemName: "photo.badge.magnifyingglass")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderless)
                        }
                        .listRowSeparator(.hidden, edges: .top)
                        .listRowSeparator(viewModel.photosUrlArray.isEmpty ? .hidden : .visible, edges: .bottom)
                        // MARK: --------------- PHOTOS GALLERY ---------------------------
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.photosUrlArray, id: \.self) { photoUrl in
                                if let uiImage = UIImage(contentsOfFile: photoUrl.path) {
                                    Button {
                                        viewModel.photoDetailUrl = photoUrl
                                        viewModel.showPhotoDetail = true
                                    }
                                    label: {
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
                        .listRowSeparator(.hidden)
                    } header: {
                        HeaderTextUIView(text: .photos)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(.save,
                           systemImage: "checkmark",
                           role: viewModel.btnDoneRole,
                           action: {
                        if viewModel.saveDamage() {
                            viewModel.sheetPresented.wrappedValue = false
                        }
                    })
                    .disabled(viewModel.btnDoneRole != .confirm)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.sheetPresented.wrappedValue = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(.close) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .fontWeight(.bold)
                }
            }
            .navigationTitle(.registerDamage)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            ImagePicker(sourceType: viewModel.photoType, imageURL: $viewModel.capturedImageURL)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $viewModel.showPhotoDetail) {
            if let photo = viewModel.photoDetailUrl {
                PhotoDetailUIView(photoUrl: photo,
                                  onDelete: {
                    viewModel.deletePhoto()
                })
                    .ignoresSafeArea()
            }
        }
        .onChange(of: viewModel.capturedImageURL) { old, new in
            if let newPhoto = new {
                viewModel.savePhoto(newPhoto)
            }
        }
    }
}

#Preview {
    let schema = Schema([EstateModel.self,
                         HabitationalUnitModel.self,
                         TenantModel.self,
                         DamageModel.self,
                         PaymentModel.self])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: [config])
    
    let tenant = TenantModel(name: "Homero Simpson",
                             identification: "123142345",
                             identification_type: "CC")
    let hu1 = HabitationalUnitModel(name: "HU1",
                                    tenant: tenant)
    let estate = EstateModel(name: "Edificio",
                             address: "Avenida",
                             habitationalUnits: [hu1])
    
    container.mainContext.insert(tenant)
    container.mainContext.insert(hu1)
    container.mainContext.insert(estate)
    
    let huRepository = HabitationalUnitModelRepository(container)
    let useCase = SaveDamageUseCase(modelContext: container.mainContext,
                                    habitationalUnitRepository: huRepository)
    let damageModel = DamageModel(damage: "Daño de prueba reportado",
                                  created_at: Date(),
                                  state: .inProgress,
                                  issuer: "Homero Simpson",
                                  photoPaths: nil)
    
    let vm = RecordDamageViewModel(huId: hu1.id.uuidString,
                                   sheetPresented: .constant(true),
                                   habitationalUnitRepository: huRepository,
                                   saveDamageUseCase: useCase,
                                   damageModel: nil)
    
    let photosUrl = [createMockImagefile(named: "p1.jpg", systemSymbol: "exclamationmark.triangle"),
                     createMockImagefile(named: "p2.jpg", systemSymbol: "photo"),
                     createMockImagefile(named: "p3.jpg", systemSymbol: "exclamationmark.triangle"),
                     createMockImagefile(named: "p4.jpg", systemSymbol: "photo"),
                     createMockImagefile(named: "p5.jpg", systemSymbol: "exclamationmark.triangle"),
                     createMockImagefile(named: "p6.jpg", systemSymbol: "photo")]
    
    vm.photosUrlArray = photosUrl
    
    func createMockImagefile(named fileName: String, systemSymbol: String) -> URL {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        // Generamos una imagen usando un SF Symbol como base para el test visual
        if let uiImage = UIImage(systemName: systemSymbol)?
            .withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
           let data = uiImage.jpegData(compressionQuality: 0.8) {
            try? data.write(to: url)
        }
        return url
    }
    
    
    return RecordDamageUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
