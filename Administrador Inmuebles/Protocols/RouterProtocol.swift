//
//  RouterProtocol.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 15/10/26.
//
import SwiftUI

protocol RouterProtocol {
    //var path: NavigationPath { get set }
    var path: [Screen] { get set }
    
    func navigateTo(route: Destination)
}
