import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/RecordPayment/RecordPaymentUIView.swift", line: 1)
//
//  RecordPaymentUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 29/10/26.
//

import SwiftUI
import SwiftData

enum RecordPaymentViewTextField: Hashable {
    case amount, paid_by
}

struct RecordPaymentUIView: View {
    @State var viewModel: RecordPaymentViewModel
    @State private var reportedByBuffer: String = ""
    @FocusState private var focused: RecordPaymentViewTextField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    // MARK: --------------- PAYMENT AMOUNT ---------------------------
                    Section {
                        TextField(__designTimeString("#12722_0", fallback: "0.00"), value: $viewModel.amount, format: .currency(code: __designTimeString("#12722_1", fallback: "COP")))
                            .keyboardType(.decimalPad)
                            .focused($focused, equals: .amount)
                            .onChange(of: viewModel.amount) { old, new in
                                viewModel.checkStatus()
                            }
                    } header: {
                        HeaderTextUIView(text: .amount)
                    }
                    // MARK: --------------- PAYMENT DATE ---------------------------
                    Section {
                        DatePicker(.select,
                                   selection: $viewModel.createdAt,
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .tint(.accentColor)
                        .padding()
                    } header: {
                        HeaderTextUIView(text: .paymentDate)
                    }
                    // MARK: --------------- PAYER NAME ---------------------------
                    Section {
                        SelectOrEnterNameUIView(pickerValueSelected: $viewModel.pickerValueSelected,
                                                issuerTyped: $viewModel.issuerTyped,
                                                otherFieldDisabled: $viewModel.otherFieldDisabled,
                                                names: viewModel.names,
                                                reportedByBuffer: reportedByBuffer,
                                                maxChars: RecordDamageUIView.MAX_REPORTED_BY_CHARS,
                                                labelTextField: String(localized: __designTimeString("#12722_2", fallback: "paid_by")))
                    } header: {
                        HeaderTextUIView(text: .paidBy)
                    }
                    // MARK: --------------- PAYMENT BANK ---------------------------
                    Section {
                        Picker(.select, selection: $viewModel.bankNameSelected) {
                            ForEach(viewModel.bankNames, id: \.self) { name in
                                Text(name)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: viewModel.bankNameSelected) { old, new in
                            viewModel.checkStatus()
                            focused = nil
                        }
                    } header: {
                        HeaderTextUIView(text: .bank)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(.save,
                           systemImage: __designTimeString("#12722_3", fallback: "checkmark"),
                           role: viewModel.btnDoneRole,
                           action: {
                        if viewModel.savePayment() {
                            viewModel.sheetPresented.wrappedValue = __designTimeBoolean("#12722_4", fallback: false)
                        }
                    })
                    .disabled(viewModel.btnDoneRole != .confirm)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.sheetPresented.wrappedValue = __designTimeBoolean("#12722_5", fallback: false)
                    } label: {
                        Image(systemName: __designTimeString("#12722_6", fallback: "xmark"))
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
            .navigationTitle(.registerPayment)
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
    let useCase = SavePaymentUseCase(modelContext: container.mainContext,
                                     habitationalUnitRepository: huRepository)
    let vm = RecordPaymentViewModel(huId: hu1.id.uuidString,
                                    sheetPresented: .constant(true),
                                    habitationalUnitRepository: huRepository,
                                    savePaymentUseCase: useCase)
    
    return RecordPaymentUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
