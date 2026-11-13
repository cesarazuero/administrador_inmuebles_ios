//
//  UIImage+Extension.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 5/11/26.
//
import SwiftUI

extension UIImage {
    func normalized() -> UIImage {
        if imageOrientation == .up { return self }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage ?? self
    }
}
