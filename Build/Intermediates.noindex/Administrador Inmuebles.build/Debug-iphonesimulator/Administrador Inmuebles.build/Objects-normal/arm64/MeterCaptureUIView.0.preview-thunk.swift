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
        VStack(spacing: 15) {
            Text(.registerReading)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .padding(.top, 20)
            
            Color.clear.frame(height: 10)
            
            TextField(.reading,
                      text: $viewModel.measure)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .frame(height: 40)
            .background {
                RoundedRectangle(cornerRadius: 10).fill(.darkGrayBackground)
            }
            
            Color.clear.frame(height: 5)
            
            HStack {
                Button(role: .confirm) {
                    viewModel.saveMeter()
                } label: {
                    Text(viewModel.processing.buttonLabel)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
                .disabled((viewModel.processing != .processing && viewModel.processing != .success) || viewModel.measure.isEmpty)
                
                Button(role: .cancel) {
                    viewModel.presentMeterCapture = false
                } label: {
                    Text(.close)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
            }
            
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    let vm = DependencyContainer.shared.createMeterCaptureViewModel()
    
    MeterCaptureUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
