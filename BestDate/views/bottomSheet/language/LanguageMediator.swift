//
//  LanguageMediator.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import Foundation

class LanguageMediator: ObservableObject {
    static var shared = LanguageMediator()

    @Published var itemList: [LanguageTypesListItem] = []

    init() {
        self.itemList.append(LanguageTypesListItem(id: 0, type: .en))
        self.itemList.append(LanguageTypesListItem(id: 1, type: .de))
        self.itemList.append(LanguageTypesListItem(id: 2, type: .ru))
        self.itemList.append(LanguageTypesListItem(id: 3, type: .uk))
    }

    func saveLanguage(language: LanguageType) {
        SettingsMediator.shared.language = language.name
        language.setLanguage()
    }
}

struct LanguageTypesListItem {
    var id: Int
    var type: LanguageType
}

enum LanguageType: String {
    case en
    case de
    case ru
    case uk

    var name: String {
        switch self {
        case .en: return "English"
        case .de: return "Deutsch"
        case .ru: return "Русский"
        case .uk: return "Український"
        }
    }

    func setLanguage() {
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.set([self.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        print(">>> setted new language - \(self.rawValue)")
    }
}
