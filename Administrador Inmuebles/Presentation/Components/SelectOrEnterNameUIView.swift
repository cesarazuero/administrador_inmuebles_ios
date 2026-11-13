//
//  SelectOrEnterNameUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 29/10/26.
//

import SwiftUI

struct SelectOrEnterNameUIView: View {
    @Binding var pickerValueSelected: String
    @Binding var issuerTyped: String
    @Binding var otherFieldDisabled: Bool
    
    @State var names: [String]
    @State var reportedByBuffer: String
    @State var maxChars:Int
    
    @FocusState var focusedField: FocusedFields?
    
    var labelTextField: String
    
    var body: some View {
        HStack(spacing: 30) {
            Picker(.select, selection: $pickerValueSelected) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.menu)
        }
        
        TextField(labelTextField,
                  text: $issuerTyped)
            .disabled(otherFieldDisabled)
            .focused($focusedField, equals: .other)
            .onAppear {
                reportedByBuffer = issuerTyped
            }
            .onChange(of: reportedByBuffer) { old, new in
                if new.count > maxChars {
                    reportedByBuffer = String(new.prefix(maxChars))
                } else {
                    issuerTyped = reportedByBuffer
                }
            }
            .onChange(of: pickerValueSelected) { _, _ in
                otherFieldDisabled = pickerValueSelected != String(localized: "other")
                
                if otherFieldDisabled {
                    issuerTyped = ""
                }
            }
    }
}
