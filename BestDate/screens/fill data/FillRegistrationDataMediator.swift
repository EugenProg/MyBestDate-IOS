//
//  FillRegistrationDataMediator.swift
//  BestDate
//
//  Created by Евгений on 25.09.2022.
//

import Foundation

class FillRegistrationDataMediator: ObservableObject {
    static var shared = FillRegistrationDataMediator()

    @Published var user: UserInfo = UserInfo()
    @Published var gender: String = ""
    @Published var birthday: Date = Date.getEithteenYearsAgoDate()
    @Published var name: String = ""
    @Published var nameInputMode: Bool = false

    func setUserData() {
        self.user = UserDataHolder.shared.getUser()
        self.name = user.name ?? ""
        self.nameInputMode = user.name?.isEmpty == true
        self.birthday = MainMediator.shared.user.birthday?.toDate() ?? Date.getEithteenYearsAgoDate()
        self.gender = self.getGender(gender: user.gender, lookFor: user.look_for)
    }

    func setGender(gender: String) {
        self.gender = gender
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

    func getUserData() -> UpdateUserDataRequest {
        UpdateUserDataRequest(name: self.name,
                              gender: self.getNewGender(),
                              birthday: self.birthday.toServerDate(),
                              look_for: self.getAim())
    }

    func saveData(completion: @escaping () -> Void) {
        CoreApiService.shared.updateUserData(data: getUserData()) { success, user in
            DispatchQueue.main.async {
                if success {
                    PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                    RegistrationMediator.shared.setUserData(user: user)
                    QuestionnaireMediator.shared.setEditInfo(user: user, editMode: false)
                    ProfileMediator.shared.setUser(user: user)
                    MainMediator.shared.setUserInfo()
                }
            }
            completion()
        }
    }
}
