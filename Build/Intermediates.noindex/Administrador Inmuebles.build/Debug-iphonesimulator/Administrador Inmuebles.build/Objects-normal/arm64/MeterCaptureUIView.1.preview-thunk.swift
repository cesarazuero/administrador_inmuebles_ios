import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Volumes/ORICO/Documentos/Administrador Inmuebles/Administrador Inmuebles/Administrador Inmuebles/Presentation/Components/MeterCapture/MeterCaptureUIView.swift", line: 1)
//
//  MeterCaptureUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//

import SwiftUI

struct MeterCaptureUIView: View {
    @State var viewModel: MeterCaptureViewModel
    
    var body: some View {
        VStack(spacing: __designTimeInteger("#9218_0", fallback: 15)) {
            Text("\(String(localized: __designTimeString("#9218_1", fallback: "register_reading"))) \(viewModel.typeSelected.localized)")
                .font(.system(size: __designTimeInteger("#9218_2", fallback: 22), weight: .bold, design: .rounded))
                .padding(.top, __designTimeInteger("#9218_3", fallback: 20))
            
            Color.clear.frame(height: __designTimeInteger("#9218_4", fallback: 10))
            
            TextField(.reading,
                      text: $viewModel.measure)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .font(.system(size: __designTimeInteger("#9218_5", fallback: 16), weight: .regular, design: .rounded))
            .frame(height: __designTimeInteger("#9218_6", fallback: 40))
            .background {
                RoundedRectangle(cornerRadius: __designTimeInteger("#9218_7", fallback: 10)).fill(.darkGrayBackground)
            }
            
            DatePicker(.select,
                       selection: $viewModel.dateSelected,
                       displayedComponents: [.date]
            )
            .datePickerStyle(.compact)
            .tint(.accentColor)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: __designTimeInteger("#9218_8", fallback: 10)).fill(.darkGrayBackground)
            }
            
            Color.clear.frame(height: __designTimeInteger("#9218_9", fallback: 5))
            
            HStack {
                Button {
                    viewModel.saveMeter()
                } label: {
                    Text(viewModel.processing.buttonLabel)
                        .font(.system(size: __designTimeInteger("#9218_10", fallback: 18), weight: .medium, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .tint(viewModel.processing.tintButton)
                .buttonSizing(.flexible)
                .disabled(viewModel.processing == .processing || viewModel.processing == .success || viewModel.measure.isEmpty)
                
                Button(role: .cancel) {
                    viewModel.presentMeterCapture = __designTimeBoolean("#9218_11", fallback: false)
                } label: {
                    Text(.close)
                        .font(.system(size: __designTimeInteger("#9218_12", fallback: 18), weight: .medium, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
            }
            
            Spacer()
        }
        .padding(__designTimeInteger("#9218_13", fallback: 20))
    }
}

#Preview {
    let vm = DependencyContainer.shared.createMeterCaptureViewModel()
    
    MeterCaptureUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
