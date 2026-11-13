import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/RecordDamage/RecordDamageUIView.swift", line: 1)
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
                                .font(.system(size: __designTimeInteger("#9554_0", fallback: 16), weight: .regular, design: .rounded))
                                .frame(height: __designTimeInteger("#9554_1", fallback: 150))
                                .focused($focusedField, equals: .damage)
                            
                            if viewModel.damageBuffer.isEmpty {
                                Text(.damageDescription)
                                    .foregroundColor(.secondary.opacity(__designTimeFloat("#9554_2", fallback: 0.7)))
                                    .font(.system(size: __designTimeInteger("#9554_3", fallback: 16), weight: .regular, design: .rounded))
                                    .padding(.top, __designTimeInteger("#9554_4", fallback: 10))
                                    .padding(.leading, __designTimeInteger("#9554_5", fallback: 6))
                                    .allowsHitTesting(__designTimeBoolean("#9554_6", fallback: false))
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
                        DatePicker(.select,
                                   selection: $viewModel.created_at,
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .tint(.accentColor)
                        .padding()
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
                                                labelTextField: String(localized: __designTimeString("#9554_7", fallback: "reported_by")))
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
                                                .frame(width: __designTimeInteger("#9554_8", fallback: 15), height: __designTimeInteger("#9554_9", fallback: 15))
                                                .shadow(color: state.getColor(),
                                                        radius: __designTimeInteger("#9554_10", fallback: 10),
                                                        x: __designTimeInteger("#9554_11", fallback: 0),
                                                        y: __designTimeInteger("#9554_12", fallback: 0))
                                            Text(state.localizedName)
                                                .font(.system(size: __designTimeInteger("#9554_13", fallback: 12), weight: .regular, design: .rounded))
                                                .frame(maxWidth: .infinity,
                                                       maxHeight: .infinity,
                                                       alignment: .top)
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(.vertical, __designTimeInteger("#9554_14", fallback: 10))
                                        .background {
                                            RoundedRectangle(cornerRadius: __designTimeInteger("#9554_15", fallback: 10))
                                                .fill(.white.opacity(viewModel.stateSelected == state ? __designTimeFloat("#9554_16", fallback: 0.1) : __designTimeFloat("#9554_17", fallback: 0.0)))
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
                        HStack(spacing: __designTimeInteger("#9554_18", fallback: 25)) {
                            Spacer()
                            
                            Button {
                                viewModel.takePhoto()
                                focusedField = nil
                            } label: {
                                Image(systemName: __designTimeString("#9554_19", fallback: "camera"))
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderless)
                            
                            Button {
                                viewModel.selectPhotoFromGallery()
                                focusedField = nil
                            } label: {
                                Image(systemName: __designTimeString("#9554_20", fallback: "photo.badge.magnifyingglass"))
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
                                        viewModel.showPhotoDetail = __designTimeBoolean("#9554_21", fallback: true)
                                    }
                                    label: {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: __designTimeInteger("#9554_22", fallback: 65), height: __designTimeInteger("#9554_23", fallback: 80))
                                            .clipped()
                                            .clipShape(RoundedRectangle(cornerRadius: __designTimeInteger("#9554_24", fallback: 10)))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: __designTimeInteger("#9554_25", fallback: 12))
                                                    .stroke(Color.gray.opacity(__designTimeFloat("#9554_26", fallback: 0.3)), lineWidth: __designTimeInteger("#9554_27", fallback: 1))
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
                           systemImage: __designTimeString("#9554_28", fallback: "checkmark"),
                           role: viewModel.btnDoneRole,
                           action: {
                        if viewModel.saveDamage() {
                            viewModel.sheetPresented.wrappedValue = __designTimeBoolean("#9554_29", fallback: false)
                        }
                    })
                    .disabled(viewModel.btnDoneRole != .confirm)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.sheetPresented.wrappedValue = __designTimeBoolean("#9554_30", fallback: false)
                    } label: {
                        Image(systemName: __designTimeString("#9554_31", fallback: "xmark"))
                            .foregroundColor(.white)
                    }
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
           let data = uiImage.jpegData(compressionQuality: __designTimeFloat("#9554_32", fallback: 0.8)) {
            try? data.write(to: url)
        }
        return url
    }
    
    
    return RecordDamageUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
