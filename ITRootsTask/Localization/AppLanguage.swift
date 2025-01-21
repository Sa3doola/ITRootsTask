//
//  AppLanguage.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

enum AppLanguage: String {
    case english = "en"
    case arabic = "ar"
}

struct Language {
    
    enum Languages {
        static let en = "en"
        static let ar = "ar"
    }
    
    static func currentLanguage() -> String {
        let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        let firstLanguage = languages.firstObject as! String
        return firstLanguage
    }
    static func setAppLanguage(lang: String) {
        guard !self.currentLanguage().lowercased().contains(lang.lowercased()) else {return}
        UserDefaults.standard.set([lang, currentLanguage()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Language.handleViewDirection()
        Bundle.swizzleLocalization()
    }
    
    static func apiLanguage() -> String {
        return self.currentLanguage().contains(Languages.ar) ? Languages.ar : Languages.en
    }
    
    static func appLanguage() -> AppLanguage {
        return self.currentLanguage().contains(Languages.ar) ? .arabic : .english
    }
    
    static func isRTL() -> Bool {
        return self.currentLanguage().contains(Languages.ar) ? true : false
    }
    
    static func handleViewDirection() {
        UIPageControl.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIStackView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UISwitch.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIButton.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITableView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().textAlignment = Language.isRTL() ? .right : .left
        UIDatePicker.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UIPickerView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UILabel.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextView.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
