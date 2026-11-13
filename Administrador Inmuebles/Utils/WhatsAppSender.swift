//
//  WhatsappSender.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 11/11/26.
//

import UIKit

@MainActor
@Observable
final class WhatsAppSender {
    var whatsAppFailed = false
    let titleAlert = String(localized: "title_error_whatsapp")
    let messageAlert = String(localized: "message_error_whatsapp")

    func send(to number: Int?, message: String = "") {
        guard let number else { return }

        let cleaned = String(number).filter { $0.isNumber }

        var components = URLComponents()
        components.scheme = "https"
        components.host = "wa.me"
        components.path = "/\(cleaned)"
        if !message.isEmpty {
            components.queryItems = [URLQueryItem(name: "text", value: message)]
        }

        guard let url = components.url else {
            whatsAppFailed = true
            return
        }

        Task {
            let success = await UIApplication.shared.open(url)
            if !success {
                whatsAppFailed = true
            }
        }
    }
}
