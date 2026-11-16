//
//  FeeCalculationUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 13/11/26.
//

import SwiftUI

struct FeeCalculationUIView: View {
    @State var viewModel: FeeCalculationViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("\(String(localized: "calculate_fee")) \(viewModel.service.localized)")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .padding(.top, 20)
            
            Color.clear.frame(height: 10)
            
            HStack {
                Image(systemName: viewModel.service.icon)
                
                Text(.readingAmount)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                
                Spacer()
                
                Text(viewModel.readingAmount, format: .number.precision(.fractionLength(0...2)))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .padding()
            
            TextField(.fee,
                      text: $viewModel.price,
                      prompt: Text(.fee)
                                .foregroundStyle(.gray)
                                .font(.system(size: 16, weight: .regular, design: .rounded)))
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(height: 40)
                .foregroundStyle(.darkGrayBackground)
                .background {
                    RoundedRectangle(cornerRadius: 10).fill(.grayBackgroundList)
                }
            
            if let total = viewModel.total {
                VStack(spacing: 4) {
                    Text(String(localized: "total", defaultValue: "Total"))
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.darkGrayBackground)
                    
                    Text(total, format: .currency(code: "COP"))
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10).fill(.grayBackgroundList)
                }
                .overlay {
                    ZStack(alignment: .topTrailing) {
                        Color.clear
                        
                        Button {
                            viewModel.presentShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding(5)
                }
            }
            
            Button(role: .cancel) {
                viewModel.presentFeeSheet = false
            } label: {
                Text(.close)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.presentShareSheet) {
            ActivityView(activityItems: [viewModel.stringToShare])
        }
        .padding(20)
        .onChange(of: viewModel.presentFeeSheet) { old, new in
            if !new {
                viewModel.clearAll()
            }
        }
    }
}

#Preview {
    let vm = FeeCalculationViewModel()
    vm.setReadingAmount(amount: 500.0)
    
    return FeeCalculationUIView(viewModel: vm)
                .preferredColorScheme(.dark)
}
