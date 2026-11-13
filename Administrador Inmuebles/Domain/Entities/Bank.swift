//
//  Bank.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 30/10/26.
//

import Foundation

struct Bank: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let code: String
    let shortCode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nombre"
        case code = "codigo"
        case shortCode = "codigo_corto"
    }
}
