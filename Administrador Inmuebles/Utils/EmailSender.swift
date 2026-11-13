//
//  EmailSender.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 11/11/26.
//

import UIKit

@MainActor
@Observable
final class EmailSender {
    var emailFailed = false
    let titleAlert = String(localized: "title_error_email")
    let messageAlert = String(localized: "message_error_email")

    func send(to email: String?, subject: String = "", body: String = "") {
        guard let email, !email.isEmpty else { return }

        var components = URLComponents()
        components.scheme = "mailto"
        components.path = email
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]

        guard let url = components.url else {
            emailFailed = true
            return
        }

        Task {
            let success = await UIApplication.shared.open(url)
            
            if !success {
                emailFailed = true
            }
        }
    }
}
