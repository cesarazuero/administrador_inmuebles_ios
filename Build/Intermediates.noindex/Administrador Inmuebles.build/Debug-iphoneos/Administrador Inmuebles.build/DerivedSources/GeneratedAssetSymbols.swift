import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "AppBackground" asset catalog color resource.
    static let appBackground = DeveloperToolsSupport.ColorResource(name: "AppBackground", bundle: resourceBundle)

    /// The "darkGrayBackground" asset catalog color resource.
    static let darkGrayBackground = DeveloperToolsSupport.ColorResource(name: "darkGrayBackground", bundle: resourceBundle)

    /// The "dark_green_button" asset catalog color resource.
    static let darkGreenButton = DeveloperToolsSupport.ColorResource(name: "dark_green_button", bundle: resourceBundle)

    /// The "gray_background_list" asset catalog color resource.
    static let grayBackgroundList = DeveloperToolsSupport.ColorResource(name: "gray_background_list", bundle: resourceBundle)

    /// The "light_green_button" asset catalog color resource.
    static let lightGreenButton = DeveloperToolsSupport.ColorResource(name: "light_green_button", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "Logo" asset catalog image resource.
    static let logo = DeveloperToolsSupport.ImageResource(name: "Logo", bundle: resourceBundle)

    /// The "Logo_sin_casa" asset catalog image resource.
    static let logoSinCasa = DeveloperToolsSupport.ImageResource(name: "Logo_sin_casa", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "AppBackground" asset catalog color.
    static var appBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appBackground)
#else
        .init()
#endif
    }

    /// The "darkGrayBackground" asset catalog color.
    static var darkGrayBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .darkGrayBackground)
#else
        .init()
#endif
    }

    /// The "dark_green_button" asset catalog color.
    static var darkGreenButton: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .darkGreenButton)
#else
        .init()
#endif
    }

    /// The "gray_background_list" asset catalog color.
    static var grayBackgroundList: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grayBackgroundList)
#else
        .init()
#endif
    }

    /// The "light_green_button" asset catalog color.
    static var lightGreenButton: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lightGreenButton)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "AppBackground" asset catalog color.
    static var appBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .appBackground)
#else
        .init()
#endif
    }

    /// The "darkGrayBackground" asset catalog color.
    static var darkGrayBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .darkGrayBackground)
#else
        .init()
#endif
    }

    /// The "dark_green_button" asset catalog color.
    static var darkGreenButton: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .darkGreenButton)
#else
        .init()
#endif
    }

    /// The "gray_background_list" asset catalog color.
    static var grayBackgroundList: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grayBackgroundList)
#else
        .init()
#endif
    }

    /// The "light_green_button" asset catalog color.
    static var lightGreenButton: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .lightGreenButton)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "AppBackground" asset catalog color.
    static var appBackground: SwiftUI.Color { .init(.appBackground) }

    /// The "darkGrayBackground" asset catalog color.
    static var darkGrayBackground: SwiftUI.Color { .init(.darkGrayBackground) }

    /// The "dark_green_button" asset catalog color.
    static var darkGreenButton: SwiftUI.Color { .init(.darkGreenButton) }

    /// The "gray_background_list" asset catalog color.
    static var grayBackgroundList: SwiftUI.Color { .init(.grayBackgroundList) }

    /// The "light_green_button" asset catalog color.
    static var lightGreenButton: SwiftUI.Color { .init(.lightGreenButton) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "AppBackground" asset catalog color.
    static var appBackground: SwiftUI.Color { .init(.appBackground) }

    /// The "darkGrayBackground" asset catalog color.
    static var darkGrayBackground: SwiftUI.Color { .init(.darkGrayBackground) }

    /// The "dark_green_button" asset catalog color.
    static var darkGreenButton: SwiftUI.Color { .init(.darkGreenButton) }

    /// The "gray_background_list" asset catalog color.
    static var grayBackgroundList: SwiftUI.Color { .init(.grayBackgroundList) }

    /// The "light_green_button" asset catalog color.
    static var lightGreenButton: SwiftUI.Color { .init(.lightGreenButton) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "Logo" asset catalog image.
    static var logo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logo)
#else
        .init()
#endif
    }

    /// The "Logo_sin_casa" asset catalog image.
    static var logoSinCasa: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logoSinCasa)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "Logo" asset catalog image.
    static var logo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logo)
#else
        .init()
#endif
    }

    /// The "Logo_sin_casa" asset catalog image.
    static var logoSinCasa: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logoSinCasa)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

