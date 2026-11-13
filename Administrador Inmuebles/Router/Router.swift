//
//  Router.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 15/10/26.
//
import SwiftUI

/*@Observable
class Router: RouterProtocol {
    var path = NavigationPath()
    
    func navigateTo(route: Destination) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
}*/

@Observable
class Router: RouterProtocol {
    var path: [Screen] = []

    @ObservationIgnored var screenFactory: ((Destination) -> Screen)?

    func navigateTo(route: Destination) {
        guard let screen = screenFactory?(route) else { return }
        path.append(screen)
    }

    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
