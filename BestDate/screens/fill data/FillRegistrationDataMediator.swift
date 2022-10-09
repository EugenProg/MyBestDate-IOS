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

    func setUserData(user: UserInfo) {
        self.user = user
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
            NSLocalizedString("man_looking_for_a_man", comment: "Gender") :
            NSLocalizedString("man_looking_for_a_woman", comment: "Gender")
        } else {
            return (lookFor?.contains("male") == true) ?
            NSLocalizedString("woman_looking_for_a_man", comment: "Gender") :
            NSLocalizedString("woman_looking_for_a_woman", comment: "Gender")
        }
    }

    private func getAim() -> [String] {
        switch gender {
        case NSLocalizedString("woman_looking_for_a_man", comment: "Gender"): return ["male"]
        case NSLocalizedString("woman_looking_for_a_woman", comment: "Gender"): return ["female"]
        case NSLocalizedString("man_looking_for_a_man", comment: "Gender"): return ["male"]
        case NSLocalizedString("man_looking_for_a_woman", comment: "Gender"): return ["female"]
        default: return ["male", "female"]
        }
    }

    private func getNewGender() -> String {
        switch gender {
        case NSLocalizedString("woman_looking_for_a_man", comment: "Gender"): return "female"
        case NSLocalizedString("woman_looking_for_a_woman", comment: "Gender"): return "female"
        case NSLocalizedString("man_looking_for_a_man", comment: "Gender"): return "male"
        case NSLocalizedString("man_looking_for_a_woman", comment: "Gender"): return "male"
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
                    MainMediator.shared.setUserInfo(user: user)
                }
            }
            completion()
        }
    }
}
