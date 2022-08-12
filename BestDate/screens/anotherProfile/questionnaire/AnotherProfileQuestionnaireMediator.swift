//
//  AnotherProfileQuestionnaireMediator.swift
//  BestDate
//
//  Created by Евгений on 26.07.2022.
//

import Foundation

class AnotherProfileQuestionnaireMediator: ObservableObject {
    static var shared = AnotherProfileQuestionnaireMediator()

    @Published var user: UserInfo = UserInfo()

    @Published var generalInfo: QuestionnaireParagraph? = nil
    @Published var dataVerification: QuestionnaireParagraph? = nil
    @Published var personalInfo: QuestionnaireParagraph? = nil
    @Published var freeTime: QuestionnaireParagraph? = nil

    func setUser(user: UserInfo) {
        self.user = user
        let questinnaire = user.questionnaire ?? Questionnaire()
        self.generalInfo = getGeneralParagraph(questionnaire: questinnaire)
        self.personalInfo = getPersonalInfo(questionnaire: questinnaire)
        self.freeTime = getFreeTime(questionnaire: questinnaire)
    }

    func setUser(user: ShortUserInfo?) {
        getUserById(id: user?.id ?? 0)
    }

    private func getUserById(id: Int) {
        CoreApiService.shared.getUsersById(id: id) { success, user in
            DispatchQueue.main.async {
                if success {
                    self.setUser(user: user)
                }
            }
        }
    }

    private func getGeneralParagraph(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: NSLocalizedString("general_information", comment: "Title").uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: NSLocalizedString("about_me", comment: "Title"),
                    value: questionnaire.about_me
                ),
                QuestionnairePoint(
                    id: 1,
                    title: NSLocalizedString("height", comment: "Title"),
                    value: String.localizedStringWithFormat(
                        NSLocalizedString("cm_unit", comment: "Mask"), questionnaire.height?.toString() ?? ""
                    )
                ),
                QuestionnairePoint(
                    id: 2,
                    title: NSLocalizedString("weight", comment: "Title"),
                    value: String.localizedStringWithFormat(
                        NSLocalizedString("kg_unit", comment: "Mask"), questionnaire.weight?.toString() ?? ""
                    )
                ),
                QuestionnairePoint(
                    id: 3,
                    title: NSLocalizedString("eye_color", comment: "Title"),
                    value:  questionnaire.eye_color
                ),
                QuestionnairePoint(
                    id: 4,
                    title: NSLocalizedString("hair_color", comment: "Title"),
                    value: questionnaire.hair_color
                ),
                QuestionnairePoint(
                    id: 5,
                    title: NSLocalizedString("hair_length", comment: "Title"),
                    value: questionnaire.hair_length
                )
            ]
        )
    }

    private func getDataVerification(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: NSLocalizedString("data_verification", comment: "Title").uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: NSLocalizedString("photo", comment: "Title"),
                    value: "Photo"
                ),
                QuestionnairePoint(
                    id: 1,
                    title: NSLocalizedString("email", comment: "Title"),
                    value: self.user.email
                ),
                QuestionnairePoint(
                    id: 2,
                    title: NSLocalizedString("social_network", comment: "Title"),
                    value: questionnaire.hair_color
                ),
                QuestionnairePoint(
                    id: 3,
                    title: NSLocalizedString("phone_number", comment: "Title"),
                    value: questionnaire.hair_length
                )
            ]
        )
    }

    private func getPersonalInfo(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: NSLocalizedString("personal_information", comment: "Title").uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: NSLocalizedString("marital_status", comment: "Title"),
                    value: questionnaire.marital_status
                ),
                QuestionnairePoint(
                    id: 1,
                    title: NSLocalizedString("having_kids", comment: "Title"),
                    value: questionnaire.kids
                ),
                QuestionnairePoint(
                    id: 2,
                    title: NSLocalizedString("plase_of_residence", comment: "Title"),
                    value: questionnaire.nationality
                ),
                QuestionnairePoint(
                    id: 3,
                    title: NSLocalizedString("education", comment: "Title"),
                    value: questionnaire.education
                ),
                QuestionnairePoint(
                    id: 4,
                    title: NSLocalizedString("occupational_status", comment: "Title"),
                    value: questionnaire.occupation
                )
            ]
        )
    }

    private func getFreeTime(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: NSLocalizedString("your_free_time", comment: "Title").uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: NSLocalizedString("hobby", comment: "Title"),
                    value: questionnaire.hobby?.toString()
                ),
                QuestionnairePoint(
                    id: 1,
                    title: NSLocalizedString("types_of_sports", comment: "Title"),
                    value: questionnaire.sport?.toString()
                ),
                QuestionnairePoint(
                    id: 2,
                    title: NSLocalizedString("evening_time", comment: "Title"),
                    value: questionnaire.evening_time
                )
            ]
        )
    }
}

struct QuestionnaireParagraph {
    var title: String
    var points: [QuestionnairePoint]
}

struct QuestionnairePoint {
    var id: Int
    var title: String
    var value: String? = ""
}
