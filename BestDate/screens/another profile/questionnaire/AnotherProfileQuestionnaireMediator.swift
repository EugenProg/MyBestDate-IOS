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
    @Published var socialNetworks: [SocialNet] = []

    func setUser(user: UserInfo) {
        self.user = user
        let questinnaire = user.questionnaire ?? Questionnaire()
        self.generalInfo = getGeneralParagraph(questionnaire: questinnaire)
        self.personalInfo = getPersonalInfo(questionnaire: questinnaire)
        self.freeTime = getFreeTime(questionnaire: questinnaire)
        setSocialNetworks(links: questinnaire.socials)
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

    func translate(text: String) {
        TranslateTextApiService.shared.translate(text: text, lang: MainMediator.shared.user.language ?? "en") { success, translatedText in
            DispatchQueue.main.async {
                var questionnaire = self.user.questionnaire ?? Questionnaire()
                questionnaire.about_me = translatedText
                self.generalInfo = self.getGeneralParagraph(questionnaire: questionnaire)
            }
        }
    }

    private func getGeneralParagraph(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: "general_information".localized().uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: "about_me".localized(),
                    value: questionnaire.about_me,
                    trnaslatableView: true,
                    translatable: questionnaire.about_me?.isEmpty == false &&
                                    user.language != MainMediator.shared.user.language
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "height".localized(),
                    value: String.localizedStringWithFormat(
                        "cm_unit".localized(), questionnaire.height?.toString() ?? ""
                    )
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "weight".localized(),
                    value: String.localizedStringWithFormat(
                        "kg_unit".localized(), questionnaire.weight?.toString() ?? ""
                    )
                ),
                QuestionnairePoint(
                    id: 3,
                    title: "eye_color".localized(),
                    value:  EyeColorType().getName(questionnaire.eye_color)
                ),
                QuestionnairePoint(
                    id: 4,
                    title: "hair_color".localized(),
                    value: HeirColorType().getName(questionnaire.hair_color)
                ),
                QuestionnairePoint(
                    id: 5,
                    title: "hair_length".localized(),
                    value: HeirLengthType().getName(questionnaire.hair_length)
                )
            ]
        )
    }

    private func getDataVerification(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: "data_verification".localized().uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: "photo".localized(),
                    value: "Photo"
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "email".localized(),
                    value: self.user.email
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "social_network".localized(),
                    value: questionnaire.hair_color
                ),
                QuestionnairePoint(
                    id: 3,
                    title: "phone_number".localized(),
                    value: questionnaire.hair_length
                )
            ]
        )
    }

    private func getPersonalInfo(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: "personal_information".localized().uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: "marital_status".localized(),
                    value: MaritalStatus().getName(questionnaire.marital_status)
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "having_kids".localized(),
                    value: KidsCount().getName(questionnaire.kids)
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "plase_of_residence".localized(),
                    value: NationalityTypes().getName(questionnaire.nationality)
                ),
                QuestionnairePoint(
                    id: 3,
                    title: "education".localized(),
                    value: EducationStatus().getName(questionnaire.education)
                ),
                QuestionnairePoint(
                    id: 4,
                    title: "occupational_status".localized(),
                    value: OccupationalStatus().getName(questionnaire.occupation)
                )
            ]
        )
    }

    private func getFreeTime(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: "your_free_time".localized().uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: "hobby".localized(),
                    value: HobbyType().getNameLine(questionnaire.hobby)
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "types_of_sports".localized(),
                    value: SportTypes().getNameLine(questionnaire.sport)
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "evening_time".localized(),
                    value: EveningTimeTypes().getName(questionnaire.evening_time)
                )
            ]
        )
    }

    private func setSocialNetworks(links: [String]?) {
        socialNetworks.removeAll()
        for link in links ?? [] {
            socialNetworks.append(
                SocialNet(type: SocialTypes.getSocialTypeByLink(link: link),
                          link: link)
            )
        }
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
    var trnaslatableView: Bool = false
    var translatable: Bool = false
}

