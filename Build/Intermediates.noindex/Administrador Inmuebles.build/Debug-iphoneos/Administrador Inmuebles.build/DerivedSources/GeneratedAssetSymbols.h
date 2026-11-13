#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.cesar.Administrador-Inmuebles";

/// The "AppBackground" asset catalog color resource.
static NSString * const ACColorNameAppBackground AC_SWIFT_PRIVATE = @"AppBackground";

/// The "darkGrayBackground" asset catalog color resource.
static NSString * const ACColorNameDarkGrayBackground AC_SWIFT_PRIVATE = @"darkGrayBackground";

/// The "dark_green_button" asset catalog color resource.
static NSString * const ACColorNameDarkGreenButton AC_SWIFT_PRIVATE = @"dark_green_button";

/// The "gray_background_list" asset catalog color resource.
static NSString * const ACColorNameGrayBackgroundList AC_SWIFT_PRIVATE = @"gray_background_list";

/// The "light_green_button" asset catalog color resource.
static NSString * const ACColorNameLightGreenButton AC_SWIFT_PRIVATE = @"light_green_button";

/// The "Logo" asset catalog image resource.
static NSString * const ACImageNameLogo AC_SWIFT_PRIVATE = @"Logo";

/// The "Logo_sin_casa" asset catalog image resource.
static NSString * const ACImageNameLogoSinCasa AC_SWIFT_PRIVATE = @"Logo_sin_casa";

#undef AC_SWIFT_PRIVATE
