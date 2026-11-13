import func SwiftUI.__designTimeSelection

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
        __designTimeSelection(NavigationStack {
            __designTimeSelection(ZStack {
                __designTimeSelection(List {
                    // MARK: --------------- PAYMENT AMOUNT ---------------------------
                    __designTimeSelection(Section {
                        __designTimeSelection(TextField(__designTimeString("#12722_0", fallback: "0.00"), value: __designTimeSelection($viewModel.amount, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value"), format: __designTimeSelection(.currency(code: __designTimeString("#12722_1", fallback: "COP")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[2]"))
                            .keyboardType(.decimalPad)
                            .focused(__designTimeSelection($focused, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].modifier[1].arg[0].value"), equals: .amount)
                            .onChange(of: __designTimeSelection(viewModel.amount, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].modifier[2].arg[0].value")) { old, new in
                                __designTimeSelection(viewModel.checkStatus(), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].modifier[2].arg[1].value.[0]")
                            }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0]")
                    } header: {
                        __designTimeSelection(Text(.amount)
                            .foregroundStyle(.white)
                            .font(__designTimeSelection(.system(size: __designTimeInteger("#12722_2", fallback: 16), weight: .bold, design: .rounded), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[1].arg[0]")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0]")
                    }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[0]")
                    // MARK: --------------- PAYMENT DATE ---------------------------
                    __designTimeSelection(Section {
                        __designTimeSelection(DatePicker(.select,
                                   selection: __designTimeSelection($viewModel.createdAt, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[1].value"),
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .tint(.accentColor)
                        .padding(), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0]")
                    } header: {
                        __designTimeSelection(Text(.damageDate)
                            .foregroundStyle(.white)
                            .font(__designTimeSelection(.system(size: __designTimeInteger("#12722_3", fallback: 16), weight: .bold, design: .rounded), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0].modifier[1].arg[0]")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1].arg[1].value.[0]")
                    }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[1]")
                    // MARK: --------------- PAYER NAME ---------------------------
                    __designTimeSelection(Section {
                        __designTimeSelection(SelectOrEnterNameUIView(pickerValueSelected: __designTimeSelection($viewModel.pickerValueSelected, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[0].value"),
                                                issuerTyped: __designTimeSelection($viewModel.issuerTyped, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[1].value"),
                                                otherFieldDisabled: __designTimeSelection(viewModel.otherFieldDisabled, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[2].value"),
                                                names: __designTimeSelection(viewModel.names, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[3].value"),
                                                reportedByBuffer: __designTimeSelection(reportedByBuffer, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[4].value"),
                                                maxChars: __designTimeSelection(RecordDamageUIView.MAX_REPORTED_BY_CHARS, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[5].value"),
                                                labelTextField: __designTimeSelection(String(localized: __designTimeString("#12722_4", fallback: "paid_by")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0].arg[6].value")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[0].value.[0]")
                    } header: {
                        __designTimeSelection(Text(.paidBy)
                            .foregroundStyle(.white)
                            .font(__designTimeSelection(.system(size: __designTimeInteger("#12722_5", fallback: 16), weight: .bold, design: .rounded), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0].modifier[1].arg[0]")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2].arg[1].value.[0]")
                    }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[2]")
                    // MARK: --------------- PAYMENT BANK ---------------------------
                    __designTimeSelection(Section {
                        __designTimeSelection(Picker(.select, selection: __designTimeSelection($viewModel.bankNameSelected, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0].arg[1].value")) {
                            __designTimeSelection(ForEach(__designTimeSelection(viewModel.bankNames, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0].arg[2].value.[0].arg[0].value"), id: \.self) { name in
                                __designTimeSelection(Text(__designTimeSelection(name, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0].arg[2].value.[0].arg[2].value.[0].arg[0].value")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0].arg[2].value.[0].arg[2].value.[0]")
                            }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0].arg[2].value.[0]")
                        }
                        .pickerStyle(.menu), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[0]")
                        __designTimeSelection(onChange(of: __designTimeSelection(viewModel.bankNameSelected, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[1].arg[0].value")) { old, new in
                            __designTimeSelection(viewModel.checkStatus(), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[1].arg[1].value.[0]")
                        }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[0].value.[1]")
                    } header: {
                        __designTimeSelection(Text(.bank)
                            .foregroundStyle(.white)
                            .font(__designTimeSelection(.system(size: __designTimeInteger("#12722_6", fallback: 16), weight: .bold, design: .rounded), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[0].modifier[1].arg[0]")), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3].arg[1].value.[0]")
                    }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value.[3]")
                }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0]")
            }
            .toolbar {
                __designTimeSelection(ToolbarItem(placement: .topBarTrailing) {
                    __designTimeSelection(Button(.save,
                           systemImage: __designTimeString("#12722_7", fallback: "checkmark"),
                           role: __designTimeSelection(viewModel.btnDoneRole, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[0].arg[1].value.[0].arg[2].value"),
                           action: {
                    })
                    .disabled(viewModel.btnDoneRole != .confirm), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[0].arg[1].value.[0]")
                }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[0]")
                
                __designTimeSelection(ToolbarItem(placement: .topBarLeading) {
                    __designTimeSelection(Button {
                        viewModel.sheetPresented.wrappedValue = __designTimeBoolean("#12722_8", fallback: false)
                    } label: {
                        __designTimeSelection(Image(systemName: __designTimeString("#12722_9", fallback: "xmark"))
                            .foregroundColor(.white), "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0].arg[1].value.[0]")
                    }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[1].arg[1].value.[0]")
                }, "#12722.[3].[3].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value.[1]")
            }
            .navigationTitle(.registerPayment), "#12722.[3].[3].property.[0].[0].arg[0].value.[0]")
        }, "#12722.[3].[3].property.[0].[0]")
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
