//
//  PerasonalDataMediator.swift
//  BestDate
//
//  Created by Евгений on 14.09.2022.
//

import Foundation

class PersonalDataMediator: ObservableObject {
    static var shared = PersonalDataMediator()
    var savedUser: UserInfo = UserInfo()

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""

    @Published var gender: String = ""
    @Published var birthday: Date = Date.getEithteenYearsAgoDate()

    @Published var saveEnable: Bool = false

    func setUserData() {
        self.savedUser = MainMediator.shared.user
        
        self.name = MainMediator.shared.user.name ?? ""
        self.email = MainMediator.shared.user.email ?? ""
        self.phone = MainMediator.shared.user.phone ?? ""
        self.birthday = MainMediator.shared.user.birthday?.toDate() ?? Date.getEithteenYearsAgoDate()

        self.gender = getGender(gender: MainMediator.shared.user.gender, lookFor: MainMediator.shared.user.look_for)
    }

    func setGender(gender: String) {
        self.gender = gender
        checkChanges()
    }

    private func getGender(gender: String?, lookFor: [String]?) -> String {
        if gender == "male" {
            return (lookFor?.contains("male") == true) ?
            NSLocalizedString("man_looking_for_a_man", comment: "Gender") :
            NSLocalizedString("man_looking_for_a_woman", comment: "Gender")
        } else {
            return (lookFor?.contains("male") == true) ?
            NSLocalizedString("woman_looking_for_a_man", comment: "Gender") :
            NSLocalizedString("woman_looking_for_a_woman", comment: "Gender")
        }
    }

    private func genderIsChanged() -> Bool {
        gender != getGender(gender: savedUser.gender, lookFor: savedUser.look_for)
    }

    func checkChanges() {
        self.saveEnable = name != savedUser.name ||
        email != savedUser.email ||
        phone != savedUser.phone ||
        birthday != savedUser.birthday?.toDate() ||
        genderIsChanged()
    }
}
