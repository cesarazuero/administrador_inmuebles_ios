//
//  CustomCompactDatePickerUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 13/11/26.
//

import SwiftUI

struct CustomCompactDatePickerUIView: View {
    @Binding var selectedDate: Date
    @State private var showPopover = false

    var body: some View {
        Button(action: {
            showPopover.toggle()
        }) {
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                
                Text(selectedDate.formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.secondary.opacity(0.12))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            )
        }
        .popover(isPresented: $showPopover) {
            VStack {
                DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.blue)
                    .padding()
                
                Button(.close) {
                    showPopover = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    var date: Date = Date()
    
    return CustomCompactDatePickerUIView(selectedDate: .constant(date))
            .preferredColorScheme(.dark)
}
