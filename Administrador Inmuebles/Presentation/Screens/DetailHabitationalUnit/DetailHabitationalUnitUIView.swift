//
//  DetailHabitationalUnitUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 3/11/26.
//
import SwiftUI
import SwiftData

struct DetailHabitationalUnitUIView: View {
    let huId: String
    
    @State private var viewModel: DetailHabitationalUnitViewModel
    @State private var phoneCall = PhoneCall()
    @State private var emailSender = EmailSender()
    @State private var whatsAppSender = WhatsAppSender()
    @State private var meterCaptureViewModel: MeterCaptureViewModel
    @State private var gasContainerCollapsed = false
    @State private var energyContainerCollapsed = false
    @State private var waterContainerCollapsed = false
    
    @Query private var hus: [HabitationalUnitModel]
    
    init(huId: String, viewModel: DetailHabitationalUnitViewModel, meterCaptureViewModel: MeterCaptureViewModel) {
        self.huId = huId
        self.viewModel = viewModel
        self.meterCaptureViewModel = meterCaptureViewModel
        
        if let idu = UUID(uuidString: huId) {
            var descriptor = FetchDescriptor<HabitationalUnitModel>(predicate: #Predicate { $0.id == idu },
                                                                    sortBy: [SortDescriptor(\.id, order: .forward)])
            descriptor.fetchLimit = 1
                                                                    
            _hus = Query(descriptor)
        }
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            List {
                // MARK: --------------- DAMAGES ---------------------------
                Section {
                    if let hu = hus.first, let damages = hu.damages, !damages.isEmpty {
                        ForEach(damages, id: \.self) { damage in
                            Button {
                                viewModel.presentDamageSheet(damage)
                            }
                            label: {
                                VStack(alignment: .leading, spacing: 15) {
                                    HStack {
                                        Text(damage.damage)
                                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        Circle()
                                            .fill(damage.state.getColor())
                                            .frame(width: 15, height: 15)
                                            .shadow(color: damage.state.getColor(),
                                                    radius: 10,
                                                    x: 0,
                                                    y: 0)
                                    }
                                    
                                    HStack {
                                        Text(damage.issuer ?? "")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text(damage.created_at.formatted(date: .abbreviated,
                                                                         time: .omitted))
                                        .font(.system(size: 14, weight: .thin, design: .rounded))
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    } else {
                        Text(.noDamagesRegistered)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }
                } header: {
                    HeaderTextUIView(text: .damages)
                }
                // MARK: --------------- PAYMENTS ---------------------------
                Section {
                    if let hu = hus.first, let payments = hu.payments, !payments.isEmpty {
                        ForEach(payments, id: \.self) { payment in
                            Button {
                                viewModel.presentPaymentSheet(payment)
                            }
                            label: {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(payment.amount.formatted(.currency(code: "COP")))
                                    
                                    Text(payment.made_by ?? "")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                    
                                    HStack {
                                        Text(payment.payment_date.formatted(date: .abbreviated,
                                                                            time: .omitted))
                                        .font(.system(size: 14, weight: .light, design: .rounded))
                                        
                                        Text(payment.bank)
                                            .font(.system(size: 14, weight: .thin, design: .rounded))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    } else {
                        Text(.noPaymentsRegistered)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }
                } header: {
                    HeaderTextUIView(text: .payments)
                }
                // MARK: --------------- PDF DOCUMENT ---------------------------
                Section {
                    if let hu = hus.first, hu.documentPDF != nil {
                        Button {
                            viewModel.presentPDFViewer = true
                        } label: {
                            HStack {
                                Image(systemName: "doc.richtext")

                                Text(hu.documentPDFName ?? String(localized: .pdfDocument))
                                    .lineLimit(1)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                        }
                        .buttonStyle(.plain)
                    } else {
                        Text(.noDocumentAttached)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }
                } header: {
                    HeaderTextUIView(text: .lease)
                }
                // MARK: --------------- READINGS ---------------------------
                if let hu = hus.first {
                    Section {
                        Text(.calculateFee)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowSeparator(.hidden)
                        
                        HStack(spacing: 15) {
                            Spacer()
                            
                            createPublicServiceButton(meters: hu.meterCaptures, publicService: .gas)
                            createPublicServiceButton(meters: hu.meterCaptures, publicService: .energy)
                            createPublicServiceButton(meters: hu.meterCaptures, publicService: .water)
                            
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                        
                        Text(.historicalRecord)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowSeparator(.hidden)
                        
                        if let meters = hu.meterCaptures, !meters.isEmpty {
                            createMeterSection(meters: meters,
                                               filteredBy: .gas,
                                               isExpanded: $gasContainerCollapsed)
                            createMeterSection(meters: meters,
                                               filteredBy: .water,
                                               isExpanded: $waterContainerCollapsed)
                            createMeterSection(meters: meters,
                                               filteredBy: .energy,
                                               isExpanded: $energyContainerCollapsed)
                        } else {
                            Text(.noReadings)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    } header: {
                        HeaderTextUIView(text: .publicServices)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                MenuRegisterDamageAndPaymentUIView { event in
                    switch event {
                    case .damage:
                        viewModel.presentDamageSheet()
                    case .payment:
                        viewModel.presentPaymentSheet()
                    case .call:
                        phoneCall.call(number: viewModel.phoneNumberTenant)
                    case .sendEmail:
                        emailSender.send(to: viewModel.emailTenant,
                                         subject: String(localized: "enter_subject"),
                                         body: String(localized: "enter_body"))
                    case .sendWhatsApp:
                        whatsAppSender.send(to: viewModel.phoneNumberTenant, message: "")
                    default:
                        print("")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                }
            }
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
        .sheet(isPresented: $viewModel.presentPDFViewer) {
            if let data = viewModel.data, let url = viewModel.shareUrl, let pdfName = viewModel.pdfName {
                PDFViewerUIView(data: data,
                                title: pdfName,
                                shareURL: url)
            }
        }
        .alert(phoneCall.titleAlert, isPresented: $phoneCall.showPhoneCallAlert) {
            Button("Aceptar", role: .cancel) { }
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.titleAlert),
                  message: Text(viewModel.messageAlert),
                  dismissButton: .default(Text(.close)))
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func createMeterSection(meters: [MeterCaptureModel], filteredBy: PublicServices, isExpanded: Binding<Bool>) -> some View {
        let measures = meters.filter { $0.type == filteredBy }.sorted(by: { $0.date < $1.date})
        
        if !measures.isEmpty {
            DisclosureGroup(isExpanded: isExpanded) {
                VStack(spacing: 0) {
                    ForEach(measures, id: \.self) { measures in
                        MeterRowUIView(measure: measures.measure, date: measures.date)
                            .tag(measures)
                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: filteredBy.icon)
                    
                    Text(filteredBy.localized)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                }
            }
        } else {
            Text("\(String(localized: "no_readings_for")) \(filteredBy.localized)")
                .font(.system(size: 16, weight: .regular, design: .rounded))
        }
    }
    
    @ViewBuilder
    private func createPublicServiceButton(meters: [MeterCaptureModel]?, publicService: PublicServices) -> some View {
        if let meters {
            Button {
                viewModel.calculateFee(meters: meters, publicService: publicService)
            } label: {
                VStack(spacing: 5) {
                    Image(systemName: publicService.icon)
                    Text(publicService.localized)
                }
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white.opacity(0.2))
                }
            }
            .tint(.white)
            .buttonStyle(.borderless)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    let schema = Schema([EstateModel.self,
                         HabitationalUnitModel.self,
                         TenantModel.self,
                         PaymentModel.self,
                         DamageModel.self,
                         MeterCaptureModel.self])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: [config])
    
    let tenant = TenantModel(name: "Tenant",
                             identification: "456456456",
                             identification_type: "P")
    
    let damage1 = DamageModel(damage: "Daño 1 reportado para 501",
                              created_at: Date(),
                              state: .created,
                              issuer: "Homero Simpson",
                              photoPaths: [])
    
    let damage2 = DamageModel(damage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis metus sit amet commodo elementum.",
                              created_at: Date(),
                              state: .fixed,
                              issuer: "Homero Simpson",
                              photoPaths: [])
    
    let damage3 = DamageModel(damage: "Daño 3 reportado para 501",
                              created_at: Date(),
                              state: .inProgress,
                              issuer: "Homero Simpson",
                              photoPaths: [])
    
    let payment1 = PaymentModel(created_at: Date(),
                                payment_date: Date(),
                                amount: 87654,
                                made_by: "Homero Simpson",
                                bank: "BANCOLOMBIA")
    
    let payment2 = PaymentModel(created_at: Date(),
                                payment_date: Date(),
                                amount: 4444444,
                                made_by: "Homero Simpson",
                                bank: "BANCO AV VILLAS")
    
    var meterModels: [MeterCaptureModel] = []
    
    for i in 0..<1 {
        let model = MeterCaptureModel(type: .energy,
                                      measure: Double.random(in: 0.0..<999.0),
                                      date: getPastDate())
        
        meterModels.append(model)
    }
    
    for i in 0..<5 {
        let model = MeterCaptureModel(type: .gas,
                                      measure: Double.random(in: 0.0..<999.0),
                                      date: getPastDate())
        
        meterModels.append(model)
    }
    
    for i in 0..<7 {
        let model = MeterCaptureModel(type: .water,
                                      measure: Double.random(in: 0.0..<999.0),
                                      date: getPastDate())
        
        meterModels.append(model)
    }
    
    let hu = HabitationalUnitModel(id: UUID(uuidString: "1234") ?? UUID(),
                                   name: "50",
                                   tenant: tenant,
                                   dueDateEnergyDay: 2,
                                   dueDateWaterDay: 4,
                                   dueDateGasDay: 6,
                                   damages: [damage1, damage2, damage3],
                                   payments: [payment1, payment2],
                                   meterCaptures: meterModels)
    
    container.mainContext.insert(damage1)
    container.mainContext.insert(damage2)
    container.mainContext.insert(damage3)
    container.mainContext.insert(payment1)
    container.mainContext.insert(payment2)
    container.mainContext.insert(hu)
    
    let vm = DetailHabitationalUnitViewModel(huId: "1234",
                                             router: Router(),
                                             huRepository: DependencyContainer.shared.getHabitationalUnitModelRepository())
    
    return NavigationStack {
        DetailHabitationalUnitUIView(huId: "1234",
                                     viewModel: vm,
                                     meterCaptureViewModel: DependencyContainer.shared.createMeterCaptureViewModel())
            .modelContainer(container)
            .preferredColorScheme(.dark)
    }
    
    func getPastDate() -> Date {
        return Calendar.current.date(byAdding: .day,
                                     value: Int.random(in: -20 ..< -1),
                                     to: Date()) ?? Date()
    }
}
