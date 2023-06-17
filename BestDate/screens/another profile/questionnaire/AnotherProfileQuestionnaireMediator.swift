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
    @Published var personalInfo: QuestionnaireParagraph? = nil
    @Published var searchConditions: QuestionnaireParagraph? = nil
    @Published var freeTime: QuestionnaireParagraph? = nil
    @Published var socialNetworks: [SocialNet] = []

    func setUser(user: UserInfo) {
        self.user = user
        let questinnaire = user.questionnaire ?? Questionnaire()
        self.generalInfo = getGeneralParagraph(questionnaire: questinnaire)
        self.searchConditions = getSearchConditions(questionnaire: questinnaire)
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

    func clearData() {
        self.user = UserInfo()

        self.generalInfo = nil
        self.personalInfo = nil
        self.searchConditions = nil
        self.freeTime = nil
        self.socialNetworks = []
    }

    func translate(text: String) {
        TranslateTextApiService.shared.translate(text: text, lang: UserDataHolder.shared.getUser().language ?? "en") { success, translatedText in
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
                                    user.language != UserDataHolder.shared.getUser().language
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "height".localized(),
                    value: getLineWithFormat(param: questionnaire.height?.toString(), format: "cm_unit")
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "weight".localized(),
                    value: getLineWithFormat(param: questionnaire.weight?.toString(), format: "kg_unit")
                ),
                QuestionnairePoint(
                    id: 3,
                    title: "eye_color".localized(),
                    value: getLine(param: EyeColorType().getName(questionnaire.eye_color))
                ),
                QuestionnairePoint(
                    id: 4,
                    title: "hair_color".localized(),
                    value: getLine(param: HeirColorType().getName(questionnaire.hair_color))
                ),
                QuestionnairePoint(
                    id: 5,
                    title: "hair_length".localized(),
                    value: getLine(param: HeirLengthType().getName(questionnaire.hair_length))
                )
            ]
        )
    }

    private func getSearchConditions(questionnaire: Questionnaire) -> QuestionnaireParagraph {
        QuestionnaireParagraph(
            title: "search_condition".localized().uppercased(),
            points: [
                QuestionnairePoint(
                    id: 0,
                    title: "purpose_of_dating".localized(),
                    value: getLine(param: PorposeOfDatingType().getName(questionnaire.purpose))
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "what_do_you_want_for_a_date".localized(),
                    value: getLine(param: AwaitFromDatingType().getName(questionnaire.expectations))
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
                    value: getLine(param: MaritalStatus().getName(questionnaire.marital_status))
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "having_kids".localized(),
                    value: getLine(param: KidsCount().getName(questionnaire.kids))
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "plase_of_residence".localized(),
                    value: getLine(param: NationalityTypes().getName(questionnaire.nationality))
                ),
                QuestionnairePoint(
                    id: 3,
                    title: "education".localized(),
                    value: getLine(param: EducationStatus().getName(questionnaire.education))
                ),
                QuestionnairePoint(
                    id: 4,
                    title: "occupational_status".localized(),
                    value: getLine(param: OccupationalStatus().getName(questionnaire.occupation))
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
                    value: getLine(param: HobbyType().getNameLine(questionnaire.hobby))
                ),
                QuestionnairePoint(
                    id: 1,
                    title: "types_of_sports".localized(),
                    value: getLine(param: SportTypes().getNameLine(questionnaire.sport))
                ),
                QuestionnairePoint(
                    id: 2,
                    title: "evening_time".localized(),
                    value: getLine(param: EveningTimeTypes().getName(questionnaire.evening_time))
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

    private func getLine(param: String?) -> String {
        if param == nil || param?.isEmpty == true { return "-" }
        else { return param! }
    }

    private func getLineWithFormat(param: String?, format: String) -> String {
        if param == nil || param?.isEmpty == true || param == "0" { return "-" }
        else {
            return String.localizedStringWithFormat(
                format.localized(), param!
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

