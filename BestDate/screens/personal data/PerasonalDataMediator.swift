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

    @Published var emailConfirmMode: Bool = false
    @Published var phoneConfirmMode: Bool = false

    var saveTypes: [SaveTypes] = []

    func setUserData() {
        self.savedUser = MainMediator.shared.user
        
        self.name = MainMediator.shared.user.name ?? ""
        self.email = MainMediator.shared.user.email ?? ""
        self.phone = MainMediator.shared.user.phone ?? ""
        self.birthday = MainMediator.shared.user.getBirthday()

        self.gender = getGender(gender: MainMediator.shared.user.gender, lookFor: MainMediator.shared.user.look_for)
    }

    func setGender(gender: String) {
        self.gender = gender
        checkChanges()
    }

    private func getGender(gender: String?, lookFor: [String]?) -> String {
        if gender == "male" {
            return (lookFor?.contains("male") == true) ?
            "man_looking_for_a_man".localized() :
            "man_looking_for_a_woman".localized()
        } else {
            return (lookFor?.contains("male") == true) ?
            "woman_looking_for_a_man".localized() :
            "woman_looking_for_a_woman".localized()
        }
    }

    func genderIsChanged() -> Bool {
        gender != getGender(gender: savedUser.gender, lookFor: savedUser.look_for)
    }

    func checkChanges() {
        self.saveEnable = name != savedUser.name ||
        email != savedUser.email ||
        phone != savedUser.phone ||
        birthday != savedUser.birthday?.toDate() ||
        genderIsChanged()
    }

    private func getAim() -> [String] {
        switch gender {
        case "woman_looking_for_a_man".localized(): return ["male"]
        case "woman_looking_for_a_woman".localized(): return ["female"]
        case "man_looking_for_a_man".localized(): return ["male"]
        case "man_looking_for_a_woman".localized(): return ["female"]
        default: return ["male", "female"]
        }
    }

    private func getNewGender() -> String {
        switch gender {
        case "woman_looking_for_a_man".localized(): return "female"
        case "woman_looking_for_a_woman".localized(): return "female"
        case "man_looking_for_a_man".localized(): return "male"
        case "man_looking_for_a_woman".localized(): return "male"
        default: return "male"
        }
    }

    private func getUserDataRequest() -> UpdateUserDataRequest {
        UpdateUserDataRequest(name: self.name,
                              gender: self.getNewGender(),
                              birthday: self.birthday.toServerDate(),
                              look_for: self.getAim())
    }

    private func getSaveTypes() -> [SaveTypes] {
        var types: [SaveTypes] = []
        if email != savedUser.email && email != "" { types.append(.email) }
        if phone != savedUser.phone && phone != "" { types.append(.phone) }
        if (name != savedUser.name || birthday.toServerDate() != savedUser.birthday?.toDate().toServerDate() || genderIsChanged()) {
            types.append(.data)
        }
        
        return types
    }

    func saveData(completion: @escaping () -> Void) {
        saveTypes = getSaveTypes()
        if saveTypes.contains(.data) { updateMainUserData { completion() } }
        else if saveTypes.contains(.email) { saveEmail { completion() } }
        else if saveTypes.contains(.phone) { savePhone { completion() } }
    }

    func saveEmail(completion: @escaping () -> Void) {
        CoreApiService.shared.registrUserEmail(email: self.email) { _, _ in
            DispatchQueue.main.async {
                self.emailConfirmMode = true
                completion()
            }
        }
    }

    func savePhone(completion: @escaping () -> Void) {
        CoreApiService.shared.registrUserPhone(phone: self.phone) { _, _ in
            DispatchQueue.main.async {
                self.phoneConfirmMode = true
                completion()
            }
        }
    }

    func updateMainUserData(completion: @escaping () -> Void) {
        CoreApiService.shared.updateUserData(data: getUserDataRequest()) { _, user in
            DispatchQueue.main.async {
                if !self.saveTypes.contains(.email) && !self.saveTypes.contains(.phone) {
                    ProfileMediator.shared.setUser(user: user)
                    MainMediator.shared.setUserInfo(user: user)
                    self.setUserData()
                    self.checkChanges()
                    completion()
                } else {
                    self.savedUser = user
                    if self.saveTypes.contains(.email) { self.saveEmail { completion() } }
                    else if self.saveTypes.contains(.phone) { self.savePhone { completion() } }
                }
            }
        }
    }

    func confirmEmail(code: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmUserEmail(email: email, code: code) { success, message in
            DispatchQueue.main.async {
                if success {
                    self.emailConfirmMode = !success
                    if self.saveTypes.contains(.phone) {
                        self.savePhone { completion(success, message) }
                    } else {
                        self.checkUserUpdates()
                    }
                }
            }
            completion(success, message)
        }
    }

    func confirmPhone(code: String, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmUserPhone(phone: phone, code: code) { success, message in
            DispatchQueue.main.async {
                self.phoneConfirmMode = !success
                self.checkUserUpdates()
            }
            completion(success, message)
        }
    }

    private func checkUserUpdates() {
        self.savedUser.email = self.email
        self.savedUser.phone = self.phone
        if self.saveTypes.contains(.data) {
            ProfileMediator.shared.setUser(user: self.savedUser)
            MainMediator.shared.setUserInfo(user: self.savedUser)
            self.setUserData()
        }
        self.checkChanges()
    }
}

enum SaveTypes: String {
    case email
    case phone
    case data
}
