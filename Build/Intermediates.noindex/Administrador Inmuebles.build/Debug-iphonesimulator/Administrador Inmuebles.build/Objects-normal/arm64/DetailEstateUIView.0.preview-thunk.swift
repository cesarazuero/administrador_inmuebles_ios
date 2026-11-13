#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Screens/DetailEstate/DetailEstateUIView.swift", line: 1)
//
//  DetailEstateUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 6/10/26.
//

import SwiftUI
import SwiftData

struct DetailEstateUIView: View {
    @State var viewModel: DetailEstateViewModel
    @State var phoneCall = PhoneCall()
    @State var emailSender = EmailSender()
    @State var whatsAppSender = WhatsAppSender()
    @State var meterCaptureViewModel: MeterCaptureViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            List {
                Section {
                    VStack(spacing: 15) {
                        if let units = viewModel.estate.habitationalUnits {
                            ForEach(units, id: \.id) { hu in
                                Button {
                                    viewModel.goToDetailHabitationalUnit(huId: hu.id.uuidString)
                                } label: {
                                    ItemHuGridUIView(huName: hu.name,
                                                     tenantName: hu.tenant?.name ?? "",
                                                     id: hu.id.uuidString) { event in
                                        switch event {
                                        case .damage:
                                            viewModel.presentDamageSheet(huId: hu.id.uuidString)
                                        case .payment:
                                            viewModel.presentPaymentSheet(huId: hu.id.uuidString)
                                        case .call:
                                            phoneCall.call(number: hu.tenant?.phoneNumber)
                                        case .sendEmail:
                                            emailSender.send(to: hu.tenant?.email,
                                                             subject: String(localized: "enter_subject"),
                                                             body: String(localized: "enter_body"))
                                        case .sendWhatsApp:
                                            whatsAppSender.send(to: hu.tenant?.phoneNumber)
                                        case .registerEnergy:
                                            meterCaptureViewModel.displayMeterCapture(huId: hu.id.uuidString, service: .energy)
                                        case .registerWater:
                                            meterCaptureViewModel.displayMeterCapture(huId: hu.id.uuidString,
                                                                                      service: .water)
                                        case .registerGas:
                                            meterCaptureViewModel.displayMeterCapture(huId: hu.id.uuidString,
                                                                                      service: .gas)
                                        }
                                    }
                                }
                                .id(hu.id)
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(3)
                    .scrollIndicators(.hidden)
                } header: {
                    HeaderTextUIView(text: .habitationalUnits)
                }
            }
            .listStyle(.insetGrouped)
            .background(.black)
        }
        .sheet(isPresented: $meterCaptureViewModel.presentMeterCapture) {
            MeterCaptureUIView(viewModel: meterCaptureViewModel)
                .presentationDetents([.medium, .fraction(0.45)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.presentRegisterDamageSheet) {
            if let vm = viewModel.damageViewModel {
                RecordDamageUIView(viewModel: vm)
            }
        }
        .sheet(isPresented: $viewModel.presentRegisterPaymentSheet) {
            if let vm = viewModel.paymentViewModel {
                RecordPaymentUIView(viewModel: vm)
            }
        }
        .alert(phoneCall.titleAlert, isPresented: $phoneCall.showPhoneCallAlert) {
            Button(.accept, role: .cancel) { }
        } message: {
            Text(phoneCall.messageAlert)
        }
        .alert(emailSender.titleAlert, isPresented: $emailSender.emailFailed) {
            Button(.accept, role: .cancel) { }
        } message: {
            Text(emailSender.messageAlert)
        }
        .alert(whatsAppSender.titleAlert, isPresented: $whatsAppSender.whatsAppFailed) {
            Button(.accept, role: .cancel) { }
        } message: {
            Text(whatsAppSender.messageAlert)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .navigationTitle(viewModel.estate.name)
        .navigationSubtitle(viewModel.estate.address)
    }
}

#Preview {
    var arrayHus: [HabitationalUnit] = []
    
    for i in 0..<9 {
        let tenant = Tenant(name: "Tenant \(i)",
                             identification: "456456456",
                             identification_type: "P")
        
        let hu = HabitationalUnit(name: "50\(i)",
                                  tenant: tenant,
                                   dueDateEnergyDay: 2,
                                   dueDateWaterDay: 4,
                                   dueDateGasDay: 6)
        
        arrayHus.append(hu)
    }
    
    let inmueble1 = Estate(name: "Colonia Oriental",
                           address: "Carrera 51A # 4 - 37",
                           habitationalUnits: arrayHus)
    
    let viewModel = DetailEstateViewModel(estate: inmueble1, router: Router())
    let mcvm = DependencyContainer.shared.createMeterCaptureViewModel()
    
    return NavigationStack {
        DetailEstateUIView(viewModel: viewModel, meterCaptureViewModel: mcvm)
            .preferredColorScheme(.dark)
    }
}
