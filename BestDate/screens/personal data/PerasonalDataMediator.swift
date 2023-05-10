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
        self.savedUser = UserDataHolder.shared.getUser()
        
        self.name = UserDataHolder.shared.getUser().name ?? ""
        self.email = UserDataHolder.shared.getUser().email ?? ""
        self.phone = UserDataHolder.shared.getUser().phone ?? ""
        self.birthday = UserDataHolder.shared.getUser().getBirthday()

        self.gender = getGender(gender: UserDataHolder.shared.getUser().gender, lookFor: UserDataHolder.shared.getUser().look_for)
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

    func saveData(completion: @escaping (Bool, String) -> Void) {
        saveTypes = getSaveTypes()
        if saveTypes.contains(.data) {
            updateMainUserData {  success, message in
                completion(success, message)
            }
        }
        else if saveTypes.contains(.email) {
            saveEmail { success, message in
                completion(success, message)
            }
        }
        else if saveTypes.contains(.phone) {
            savePhone { success, message in
                completion(success, message)
            }
        }
    }

    func saveEmail(completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrUserEmail(email: self.email) { success, message in
            DispatchQueue.main.async {
                self.emailConfirmMode = success
                completion(success, message)
            }
        }
    }

    func savePhone(completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrUserPhone(phone: self.phone.toPhoneFormat()) { success, message in
            DispatchQueue.main.async {
                self.phoneConfirmMode = success
                completion(success, message)
            }
        }
    }

    func updateMainUserData(completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.updateUserData(data: getUserDataRequest()) { success, user in
            DispatchQueue.main.async {
                if !self.saveTypes.contains(.email) && !self.saveTypes.contains(.phone) {
                    ProfileMediator.shared.setUser(user: user)
                    MainMediator.shared.setUserInfo()
                    self.setUserData()
                    self.checkChanges()
                    completion(success, "default_error_message".localized())
                } else {
                    self.savedUser = user
                    if self.saveTypes.contains(.email) {
                        self.saveEmail { success, message in
                            completion(success, message)
                        }
                    }
                    else if self.saveTypes.contains(.phone) {
                        self.savePhone { success, message in
                            completion(success, message)
                        }
                    }
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
                        self.savePhone {  success, message in
                            completion(success, message) }
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
            ProfileMediator.shared.setUser(user: savedUser)
            MainMediator.shared.setUserInfo()
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
