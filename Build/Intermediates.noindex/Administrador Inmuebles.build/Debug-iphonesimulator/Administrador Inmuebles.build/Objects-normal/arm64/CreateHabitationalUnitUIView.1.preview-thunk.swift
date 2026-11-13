import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/CreateHabitationalUnit/CreateHabitationalUnitUIView.swift", line: 1)
//
//  CreateHabitationalUnitUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 7/10/26.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct CreateHabitationalUnitUIView: View {
    @Environment(\.dismiss) var dismiss
    
    let meses = Calendar.current.monthSymbols
    
    @State var viewModel: CreateHabitationalUnitViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            List {
                // MARK: --------------- NAME ---------------------------
                Section {
                    TextField(.name,
                              text: $viewModel.habitationalUnit.name)
                } header: {
                    HeaderTextUIView(text: .habitationalUnit)
                }
                // MARK: --------------- TENANT ---------------------------
                Section {
                    HStack {
                        Text(viewModel.habitationalUnit.tenant?.name ?? String(localized: __designTimeString("#3160_0", fallback: "unasigned")))
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.goToCreateTenant()
                        },
                        label: {
                            Image(systemName: __designTimeString("#3160_1", fallback: "chevron.right"))
                        })
                    }
                } header: {
                    HeaderTextUIView(text: .tenant)
                }
                
                // MARK: --------------- PAYMENT AMOUNT ---------------------------
                Section {
                    TextField(__designTimeString("#3160_2", fallback: "0.00"),
                              value: $viewModel.habitationalUnit.rentAmount,
                              format: .currency(code: __designTimeString("#3160_3", fallback: "COP")))
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.habitationalUnit.rentAmount) { old, new in
                        viewModel.checkFormStatus()
                    }
                } header: {
                    HeaderTextUIView(text: .amount)
                
                }
                // MARK: --------------- DATE BEGIN RENT ---------------------------
                Section {
                    DatePicker(.select,
                               selection: $viewModel.habitationalUnit.dateBeginRent,
                               displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .tint(.accentColor)
                    .padding()
                } header: {
                    HeaderTextUIView(text: .startContractDate)
                }
                // MARK: --------------- DUE DATES ---------------------------
                Section {
                    dayPicker(day: $viewModel.habitationalUnit.dueDateEnergyDay)
                } header: {
                    HeaderTextUIView(text: .dueDayEnergy)
                }
                
                Section {
                    dayPicker(day: $viewModel.habitationalUnit.dueDateWaterDay)
                } header: {
                    HeaderTextUIView(text: .dueDayWater)
                }
                
                Section {
                    dayPicker(day: $viewModel.habitationalUnit.dueDateGasDay)
                } header: {
                    HeaderTextUIView(text: .dueDayGas)
                }

                // MARK: --------------- PDF DOCUMENT ---------------------------
                Section {
                    HStack {
                        Image(systemName: __designTimeString("#3160_4", fallback: "doc.richtext"))

                        Text(viewModel.habitationalUnit.documentPDFName ?? String(localized: .noDocumentAttached))
                            .lineLimit(__designTimeInteger("#3160_5", fallback: 1))

                        Spacer()

                        if viewModel.habitationalUnit.documentPDF != nil {
                            Button(role: .destructive) {
                                viewModel.removeDocument()
                            } label: {
                                Image(systemName: __designTimeString("#3160_6", fallback: "trash"))
                            }
                            .buttonStyle(.borderless)
                        }

                        Button {
                            viewModel.showFileImporter = __designTimeBoolean("#3160_7", fallback: true)
                        } label: {
                            Image(systemName: __designTimeString("#3160_8", fallback: "paperclip"))
                        }
                        .buttonStyle(.borderless)
                    }
                } header: {
                    HeaderTextUIView(text: .lease)
                }
            }
            .fileImporter(isPresented: $viewModel.showFileImporter,
                          allowedContentTypes: [.pdf]) { result in
                viewModel.attachDocument(result: result)
            }
            .background(.black)
            .scrollContentBackground(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(.save,
                       systemImage: __designTimeString("#3160_9", fallback: "checkmark"),
                       role: viewModel.btnDoneRole,
                       action: {
                    Keyboard.hideKeyboard()
                    viewModel.saveHabitationalUnit()
                })
                .disabled(viewModel.btnDoneRole != .confirm)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Keyboard.hideKeyboard()
                    viewModel.goBack()
                } label: {
                    Image(systemName: __designTimeString("#3160_10", fallback: "chevron.left"))
                    .foregroundColor(.white)
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button {
                    Keyboard.hideKeyboard()
                } label: {
                    Image(systemName: __designTimeString("#3160_11", fallback: "keyboard.chevron.compact.down"))
                }
                .fontWeight(.bold)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .onChange(of: viewModel.habitationalUnit.name) {
            viewModel.checkFormStatus()
        }
        .onAppear {
            viewModel.checkFormStatus()
        }
        .navigationTitle(.habitationalUnit)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func dayPicker(day: Binding<Int>) -> some View {
        Picker(.day, selection: day) {
            ForEach(__designTimeInteger("#3160_12", fallback: 1)...__designTimeInteger("#3160_13", fallback: 31), id: \.self) { dia in
                Text("\(dia)").tag(dia)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    let router = Router()
    
    NavigationStack {
        var estate = Estate()
        let schema = Schema([EstateModel.self,
                             HabitationalUnitModel.self,
                             TenantModel.self,
                             DamageModel.self,
                             PaymentModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [config])
        
        let huRepository = HabitationalUnitModelRepository(container)
        let vm = CreateHabitationalUnitViewModel(estate: estate,
                                                 id: nil,
                                                 router: Router())
        CreateHabitationalUnitUIView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
    .environment(router)
}
