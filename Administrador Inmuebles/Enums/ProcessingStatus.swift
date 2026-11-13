//
//  ProcessingStatus.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 12/11/26.
//
import Foundation
import SwiftUI

enum ProcessingStatus {
    case noProcessing, processing, success, failure
    
    var buttonLabel: String {
        switch self {
        case .noProcessing:
            return String(localized: "save")
        case .processing:
            return "\(String(localized: "processing")...)"
        case .success:
            return String(localized: "saved")
        case .failure:
            return String(localized: "error")
        }
    }
    
    var tintButton: Color {
        switch self {
        case .noProcessing:
            return .blue
        case .processing:
            return .blue
        case .success:
            return .green
        case .failure:
            return .red
        }
    }
}
