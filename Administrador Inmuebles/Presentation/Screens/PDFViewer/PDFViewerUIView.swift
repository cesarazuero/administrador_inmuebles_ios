//
//  PDFViewerUIView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 11/11/26.
//

import SwiftUI

struct PDFViewerUIView: View {
    @Environment(\.dismiss) private var dismiss
    @State var presentShare: Bool = false

    let data: Data
    let title: String
    let shareURL: URL?

    var body: some View {
        NavigationStack {
            PDFKitRepresentedView(data: data)
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            presentShare = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $presentShare) {
                    if let shareURL {
                        let _ = print("no nil")
                        ActivityView(activityItems: [shareURL])
                    } else {
                        let _ = print("nil")
                        Rectangle().fill(.red).frame(width: 100, height: 100)
                    }
                }
        }
    }

    
}
