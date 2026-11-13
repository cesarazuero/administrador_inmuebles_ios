//
//  PDFKitRepresentedView.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 11/11/26.
//

import SwiftUI
import PDFKit

/// Wraps `PDFView` so a PDF stored as `Data` can be displayed in SwiftUI.
struct PDFKitRepresentedView: UIViewRepresentable {
    let data: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(data: data)
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        // Avoid reloading the document (and losing the scroll position) on every update.
        if pdfView.document?.dataRepresentation() != data {
            pdfView.document = PDFDocument(data: data)
        }
    }
}
