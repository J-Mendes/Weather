//
//  TextUtils.swift
//  Weather
//
//  Created by Jorge Mendes on 08/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

class TextUtils {

    // MARK: - Static text utils
    
    class var currentLanguage: (langCode: String, localeCode: String)? {
        let currentLocale = Locale(identifier: Locale.preferredLanguages.first!)
        
        guard let langCode = currentLocale.languageCode else {
            return nil
        }
        
        var localeCode = langCode
        if let scriptCode = currentLocale.scriptCode {
            localeCode = "\(langCode)-\(scriptCode)"
        } else if let regionCode = currentLocale.regionCode {
            localeCode = "\(langCode)-\(regionCode)"
        }
        return (langCode, localeCode)
    }
    
    class func localizedString(_ key: String) -> String {
        let testBundle = Bundle(for: WeatherUITests.self)
        
        if let currentLanguage = currentLanguage,
            let testBundlePath = testBundle.path(forResource: currentLanguage.localeCode, ofType: "lproj") ?? testBundle.path(forResource: currentLanguage.langCode, ofType: "lproj"),
            let localizedBundle = Bundle(path: testBundlePath) {
            return NSLocalizedString(key, bundle: localizedBundle, comment: "")
        }
        return "?"
    }
    
}
