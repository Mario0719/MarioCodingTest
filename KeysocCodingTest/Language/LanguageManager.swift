//
//  LanguageManager.swift
//  KeysocCodingTest
//
//  Created by 郭嘉俊 on 2023/11/2.
//
//  国际化语言控制器单元

import Foundation

enum LanguageOptions: String {

    case EN = "English"
    case CN = "中文(简体)"
    case HK = "中文(繁体)"
    
    static func getFileName(title: String) -> String {
        switch title {
        case "English": "en"
        case "中文(繁体)": "zh-Hant"
        case "中文(简体)": "zh-Hans"
        default: "en"
        }
    }
}

public extension String {
    var localized: String {
        LanguageManager.shared.localize(string: self, bundle: Bundle.main)
    }
}

public class LanguageManager {
    public static let shared = LanguageManager()
    private static let userDefaultsKey = "current_language"
    private static let defaultLanguage = "zh-Hant"
    
    init() {
        currentLanguage = LanguageManager.storeCurrnetLanguage ?? LanguageManager.defaultLanguage
    }
    
    public static var availibleLanguages: [String] {
        Bundle.main.localizations.sorted()
    }
    
    public var currentLanguage: String {
        didSet {
            storeCurrentLanguage()
        }
    }
}

extension LanguageManager {
    ///  保存当前语言
    private func storeCurrentLanguage() {
        UserDefaults.standard.setValue(currentLanguage, forKey: LanguageManager.userDefaultsKey)
    }
    ///  获取设置的语言
    private static var storeCurrnetLanguage: String? {
        UserDefaults.standard.value(forKey: userDefaultsKey) as? String
    }
//    ///  获取推荐语言（跟随系统）
//    private static var preferredLanguage: String? {
//        Bundle.main.preferredLocalizations.first {
//            availibleLanguages.first
//        }
//    }
}

extension LanguageManager {
    public var currentLocale: Locale {
        Locale(identifier: currentLanguage)
    }
}
extension LanguageManager {
    
    public func localize(string: String, bundle: Bundle?) -> String {
        if let languageBundleUrl = bundle?.url(forResource: currentLanguage, withExtension: "lproj") {
            
            let languageBundle = Bundle(url: languageBundleUrl)
            return languageBundle!.localizedString(forKey: string, value: nil, table: nil)
        }
        return string
    }
    
    public func localize(string: String, bundle: Bundle?, arguments: [CVarArg]) -> String {
        String(format: localize(string: string, bundle: bundle), locale: currentLocale, arguments: arguments)
    }
}
