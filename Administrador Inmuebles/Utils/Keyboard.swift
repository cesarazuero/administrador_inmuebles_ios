//
//  Keyboard.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 11/11/26.
//
import SwiftUI

struct Keyboard {
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
