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
            Text("\(String(localized: "register_reading")) \(viewModel.typeSelected.localized)")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .padding(.top, 20)
            
            Color.clear.frame(height: 10)
            
            TextField(.reading,
                      text: $viewModel.measure,
                      prompt: Text(.reading)
                .foregroundStyle(.gray)
                .font(.system(size: 16, weight: .regular, design: .rounded)))
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundStyle(.darkGrayBackground)
            .frame(width: 160, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 10).fill(.grayBackgroundList)
            }
            
            CustomCompactDatePickerUIView(selectedDate: $viewModel.dateSelected)
            
            Color.clear.frame(height: 5)
            
            HStack {
                Button {
                    viewModel.saveMeter()
                } label: {
                    Text(viewModel.processing.buttonLabel)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .tint(viewModel.processing.tintButton)
                .buttonSizing(.flexible)
                .disabled(viewModel.processing == .processing || viewModel.processing == .success || viewModel.measure.isEmpty)
                
                Button(role: .cancel) {
                    viewModel.presentMeterCapture = false
                } label: {
                    Text(.close)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
            }
            
            Spacer()
        }
        .padding(20)
        .onChange(of: viewModel.presentMeterCapture) { old, new in
            if !new {
                viewModel.clearAll()
            }
        }
    }
}

#Preview {
    let vm = DependencyContainer.shared.createMeterCaptureViewModel()
    
    MeterCaptureUIView(viewModel: vm)
        .preferredColorScheme(.dark)
}
