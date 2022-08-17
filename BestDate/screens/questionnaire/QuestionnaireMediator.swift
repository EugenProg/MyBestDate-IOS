//
//  QuestionnaireMediator.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import Foundation
import SwiftUI

class QuestionnaireMediator: ObservableObject {
    static let shared = QuestionnaireMediator()

    private var savedQuestionnaire: Questionnaire = Questionnaire()

    var userQuestinnaire: Questionnaire = Questionnaire()
    var editMode: Bool = false

    @Published var progress: Int = 0
    @Published var firstSurprize: Bool = false
    @Published var finalSurprize: Bool = false
    @Published var title: String = "let_s_start"
    @Published var pages: [QuestionnairePage] = []

    @Published var saveProcess: Bool = false

    @Published var startAgeRange: Int = 5
    @Published var endAgeRange: Int = 120

    var personalPageStates = PageStates(offset: CGSize.zero, zoom: 1, opacity: 1)
    var apperancePageStates = PageStates(opacity: 0.5)
    var searchPageStates = PageStates()
    var aboutPageStates = PageStates()
    var freeTimePageStates = PageStates()
    var dataPageStates = PageStates()

    var total: Int = 0

    init() {
        total = getPageList()
    }

    func setPageStates() {
        personalPageStates = PageStates(offset: CGSize.zero, zoom: 1, opacity: 1)
        apperancePageStates = PageStates(opacity: 0.5)
        searchPageStates = PageStates()
        aboutPageStates = PageStates()
        freeTimePageStates = PageStates()
        dataPageStates = PageStates()
    }

    func setEditInfo(user: UserInfo, editMode: Bool) {
        self.setQuestionnaire(questionnaire: user.questionnaire ?? Questionnaire(), email: user.email, phone: user.phone)
        self.setUserLocation(location: user.location ?? Location())
        self.editMode = editMode
    }

    func setQuestionnaire(questionnaire: Questionnaire, email: String?, phone: String?) {
        pages[0].questions[0].selectedAnsfer = questionnaire.marital_status ?? ""
        pages[0].questions[1].selectedAnsfer = questionnaire.kids ?? ""
        pages[0].questions[2].selectedAnsfer = questionnaire.nationality ?? ""
        pages[0].questions[3].selectedAnsfer = questionnaire.education ?? ""
        pages[0].questions[4].selectedAnsfer = questionnaire.occupation ?? ""

        pages[1].questions[0].selectedAnsfer = (questionnaire.height != nil) ? (questionnaire.height ?? 0).toString() : ""
        pages[1].questions[1].selectedAnsfer = (questionnaire.weight != nil) ? (questionnaire.weight ?? 0).toString() : ""
        pages[1].questions[2].selectedAnsfer = questionnaire.eye_color ?? ""
        pages[1].questions[3].selectedAnsfer = questionnaire.hair_length ?? ""
        pages[1].questions[4].selectedAnsfer = questionnaire.hair_color ?? ""

        pages[2].questions[0].selectedAnsfer = questionnaire.purpose ?? ""
        pages[2].questions[1].selectedAnsfer = questionnaire.expectations ?? ""
        pages[2].questions[2].selectedAnsfer = createLocation(country: questionnaire.search_country, city: questionnaire.search_city)
        startAgeRange = questionnaire.search_age_min ?? 5
        endAgeRange = questionnaire.search_age_max ?? 120

        pages[3].questions[0].selectedAnsfer = (questionnaire.hobby ?? []).toString()
        pages[3].questions[1].selectedAnsfer = (questionnaire.sport ?? []).toString()
        pages[3].questions[2].selectedAnsfer = questionnaire.evening_time ?? ""

        pages[4].questions[0].selectedAnsfer = questionnaire.about_me ?? ""

        pages[5].questions[1].selectedAnsfer = email ?? ""
        pages[5].questions[2].selectedAnsfer = (questionnaire.socials ?? []).toString()
        pages[5].questions[3].selectedAnsfer = phone ?? ""

        progress = 0
        addProgress(progress: calculateSavedProgress(questionnaire: questionnaire))

        self.savedQuestionnaire = questionnaire
        self.userQuestinnaire = questionnaire
    }

    func setEmail(email: String) {
        pages[5].questions[1].selectedAnsfer = email
    }

    func setPhone(phone: String) {
        pages[5].questions[3].selectedAnsfer = phone
    }

    private func createLocation(country: String?, city: String?) -> String {
        if !(country?.isEmpty ?? true) && !(city?.isEmpty ?? true) {
            return (country ?? "") + ", " + (city ?? "")
        } else if !(country?.isEmpty ?? true) && (city?.isEmpty ?? true) {
            return country ?? ""
        } else if (country?.isEmpty ?? true) && !(city?.isEmpty ?? true) {
            return city ?? ""
        } else { return "" }

    }

    private func calculateSavedProgress(questionnaire: Questionnaire) -> Int {
        var totalProgress = 0
        for page in pages {
            for question in page.questions {
                if !question.selectedAnsfer.isEmpty && question.selectedAnsfer != "0" {
                    totalProgress += question.percent
                }
            }
        }
        return totalProgress
    }

    func saveSelection(questionInfo: QuestionInfo, ansfer: String) {
        switch (questionInfo.question) {
        case "marital_status": userQuestinnaire.marital_status = ansfer
        case "having_kids": userQuestinnaire.kids = ansfer
        case "plase_of_residence": userQuestinnaire.nationality = ansfer
        case "education": userQuestinnaire.education = ansfer
        case "occupational_status": userQuestinnaire.occupation = ansfer
        case "height": userQuestinnaire.height = ansfer.toInt()
        case "weight": userQuestinnaire.weight = ansfer.toInt()
        case "hair_length": userQuestinnaire.hair_length = ansfer
        case "eye_color": userQuestinnaire.eye_color = ansfer
        case "hair_color": userQuestinnaire.hair_color = ansfer
        case "purpose_of_dating": userQuestinnaire.purpose = ansfer
        case "what_do_you_want_for_a_date": userQuestinnaire.expectations = ansfer
        case "search_location": setLocation(ansfer: ansfer)
        case "hobby": userQuestinnaire.hobby = getListFromAnsfer(ansfer: ansfer)
        case "types_of_sports": userQuestinnaire.sport = getListFromAnsfer(ansfer: ansfer)
        case "evening_time": userQuestinnaire.evening_time = ansfer
        case "social_network": userQuestinnaire.socials = getListFromAnsfer(ansfer: ansfer)
        case "tell_us_about_yourself_what_you_find_interesting": userQuestinnaire.about_me = ansfer
        default: break

        }
    }

    private func setLocation(ansfer: String) {
        if !ansfer.isEmpty {
            let list = getListFromAnsfer(ansfer: ansfer)
            userQuestinnaire.search_country = list.first
            if list.count > 1 {
                userQuestinnaire.search_city = list[1]
            }
        }
    }

    func saveQuestionnaire(questionnaire: Questionnaire, completion: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.saveQuestionnaire(questionnaire: questionnaire) { success, user in
            if success {
                self.getUserData { success in
                    completion(success, "")
                }
            } else {
                completion(success, "default_error_message")
            }
        }
    }

    func getUserData(completion: @escaping (Bool) -> Void) {
        CoreApiService.shared.getUserData { success, user in
            if success {
                MainMediator.shared.setUserInfo(user: user)
            }
            completion(success)
        }
    }

    func getQuestionnaire() {
        userQuestinnaire.search_age_min = startAgeRange
        userQuestinnaire.search_age_max = endAgeRange
    }

    func isChanged() -> Bool {
        if savedQuestionnaire.isEmpty() { return true }

        return !(userQuestinnaire.purpose == savedQuestionnaire.purpose &&
                 userQuestinnaire.expectations == savedQuestionnaire.expectations &&
                 userQuestinnaire.height == savedQuestionnaire.height &&
                 userQuestinnaire.weight == savedQuestionnaire.weight &&
                 userQuestinnaire.eye_color == savedQuestionnaire.eye_color &&
                 userQuestinnaire.hair_color == savedQuestionnaire.hair_color &&
                 userQuestinnaire.hair_length == savedQuestionnaire.hair_length &&
                 userQuestinnaire.marital_status == savedQuestionnaire.marital_status &&
                 userQuestinnaire.kids == savedQuestionnaire.kids &&
                 userQuestinnaire.education == savedQuestionnaire.education &&
                 userQuestinnaire.occupation == savedQuestionnaire.occupation &&
                 userQuestinnaire.about_me == savedQuestionnaire.about_me &&
                 userQuestinnaire.search_age_min == savedQuestionnaire.search_age_min &&
                 userQuestinnaire.search_age_max == savedQuestionnaire.search_age_max &&
                 userQuestinnaire.search_country == savedQuestionnaire.search_country &&
                 userQuestinnaire.search_city == savedQuestionnaire.search_city &&
        (userQuestinnaire.socials?.equals(array: savedQuestionnaire.socials ?? []) ?? true) &&
        (userQuestinnaire.hobby?.equals(array: savedQuestionnaire.hobby ?? []) ?? true) &&
        (userQuestinnaire.sport?.equals(array: savedQuestionnaire.sport ?? []) ?? true) &&
                 userQuestinnaire.evening_time == savedQuestionnaire.evening_time)
    }

    func setUserLocation(location: Location) {
        if pages[2].questions[2].selectedAnsfer.isEmpty {
            pages[2].questions[2].selectedAnsfer = createLocation(country: location.country, city: location.city)
            addProgress(progress: pages[2].questions[2].percent)
        }
    }

    private func getListFromAnsfer(ansfer: String) -> [String] {
        ansfer.components(separatedBy: ", ")
    }

    private func getQuestionInfoByPageNumberAndQuestionNumber(pageNumber: Int, questionNumber: Int) -> QuestionInfo {
        let questions = getPageByNumber(number: pageNumber).questions
        return questions.first { q in
            q.id == questionNumber
        } ?? QuestionInfo(id: 0)
    }

    func addProgress(progress: Int) {
        if self.progress + progress < 100  { self.progress += progress }
        else { self.progress = 100 }
        setTitle()
        calculateSurprizesVisibility()
    }

    func removeProgress(progress: Int) {
        if self.progress - progress > 0 { self.progress -= progress }
        else { self.progress = 0 }
        setTitle()
        calculateSurprizesVisibility()
    }

    private func calculateSurprizesVisibility() {
        firstSurprize = self.progress > 48
        finalSurprize = self.progress > 89
    }

    private func setTitle() {
        switch(progress) {
        case 17...32: title = "its_ok"
        case 33...48: title = "nice"
        case 49...64: title = "perfect_result"
        case 65...80: title = "good_job"
        case 81...100: title = "excellent"
        default:
            title = "let_s_start"
        }
    }

    private func getPageList() -> Int {
        pages = [
            QuestionnairePage(number: 1, title: "personal_information", type: .SELECT, questions: getPersonalQuestions()),
            QuestionnairePage(number: 2, title: "your_appearance", type: .SELECT, questions: getApperanceQuestions()),
            QuestionnairePage(number: 3, title: "search_condition", type: .SELECT, questions: getSearchQuestions()),
            QuestionnairePage(number: 4, title: "your_free_time", type: .SELECT, questions: getFreeTimeQuestions()),
            QuestionnairePage(number: 5, title: "about_myself", type: .INPUT, questions: getAboutQuestions()),
            QuestionnairePage(number: 6, title: "data_verification", type: .SELECT, buttonTitle: "well_done", questions: getConfirmationQuestions()),
        ]
        return pages.count
    }

    func getPersonalQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "marital_status",
                percent: 5,
                ansfers: ["married", "divorced", "single", "it_s_complicated", "in_love", "engaged", "actively_searching"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "having_kids",
                percent: 7,
                ansfers: ["no", "one", "two", "three", "four", "five_or_more"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "plase_of_residence",
                percent: 4,
                ansfers: ["AB", "AU", "AT", "AZ", "AL", "DZ", "AS", "AI", "AO", "AD", "AR", "AG", "AM", "AW", "AF",
                          "BS", "BD", "BB", "BH", "BY", "BZ", "BE", "BJ", "BM", "BG", "BO", "BQ", "BA", "BW", "BR",
                          "IO", "BN", "BF", "BI", "BT", "VU", "HU", "VE", "VG", "VI", "VN", "GA", "HT", "GY", "GM",
                          "GH", "GP", "GT", "GN", "GW", "DE", "GG", "GI", "HN", "HK", "GD", "GL", "GR", "GE", "GU",
                          "DK", "JE", "DJ", "DM", "DO", "EG", "ZM", "EH", "ZW", "IL", "IN", "ID", "JO", "IQ", "IE",
                          "IS", "ES", "IT", "YE", "CV", "KZ", "KH", "CM", "CA", "QA", "KE", "CY", "KG", "KI", "CN",
                          "CC", "CO", "KM", "CG", "CD", "KP", "KR", "CR", "CI", "CU", "KW", "CW", "LA", "LV", "LS",
                          "LB", "LY", "LR", "LI", "LT", "LU", "MU", "MR", "MG", "YT", "MO", "MW", "MY", "ML", "UM",
                          "MV", "MT", "MA", "MQ", "MH", "MX", "FM", "MZ", "MD", "MC", "MN", "MS", "MM", "NA", "NR",
                          "NP", "NE", "NG", "NL", "NI", "NU", "NZ", "NC", "NO", "AE", "OM", "BV", "IM", "NF", "CX",
                          "HM", "KY", "CK", "TC", "PK", "PW", "PA", "VA", "PG", "PY", "PE", "PN", "PL", "PT", "PR",
                          "MK", "RE", "RU", "RW", "RO", "WS", "SM", "ST", "SA", "SH", "MP", "BL", "MF", "SN", "VC",
                          "KN", "LC", "PM", "RS", "SC", "SG", "SX", "SY", "SK", "SI", "GB", "US", "SB", "SO", "SD",
                          "SR", "SL", "TJ", "TH", "TW", "TZ", "TL", "TG", "TK", "TO", "TT", "TV", "TN", "TM", "TR",
                          "UG", "UZ", "UA", "WF", "UY", "FO", "FJ", "PH", "FI", "FK", "FR", "GF", "PF", "TF", "HR",
                          "CF", "TD", "ME", "CZ", "CL", "CH", "SE", "SJ", "LK", "EC", "GQ", "AX", "SV", "ER", "SZ",
                          "EE", "ET", "ZA", "GS", "OS", "SS", "JM", "JP"]
            )
        )
        list.append(
            QuestionInfo(
                id: 3,
                question: "education",
                percent: 6,
                ansfers: ["no_education", "secondary", "higher"]
            )
        )
        list.append(
            QuestionInfo(
                id: 4,
                question: "occupational_status",
                percent: 5,
                ansfers: ["student", "working", "unemployed", "businessman", "looking_for_my_self", "freelancer"]
            )
        )

        return list
    }

    func getApperanceQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "height",
                percent: 6,
                unitMask: "cm_unit",
                viewType: .SEEK_BAR_SELECT,
                ansfers: ["130", "230"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "weight",
                percent: 5,
                unitMask: "kg_unit",
                viewType: .SEEK_BAR_SELECT,
                ansfers: ["30", "150"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "eye_color",
                percent: 4,
                ansfers: ["blue", "gray", "green", "brown_yellow", "yellow", "brown", "black"]
            )
        )
        list.append(
            QuestionInfo(
                id: 3,
                question: "hair_length",
                percent: 3,
                ansfers: ["short_", "medium", "long_", "no_hair"]
            )
        )
        list.append(
            QuestionInfo(
                id: 4,
                question: "hair_color",
                percent: 5,
                ansfers: ["blond", "brunette", "redhead", "no_hair"]
            )
        )

        return list
    }

    func getSearchQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "purpose_of_dating",
                percent: 8,
                viewType: .SINGLE_SELECT,
                ansfers: ["friendship", "love", "communication", "sex"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "what_do_you_want_for_a_date",
                percent: 7,
                viewType: .SINGLE_SELECT,
                ansfers: ["having_a_fun", "interesting_communication", "serious_relationship_only", "one_time_sex"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "search_location",
                percent: 6,
                viewType: .SEARCH_SELECT,
                ansfers: []
            )
        )
        list.append(
            QuestionInfo(
                id: 3,
                question: "search_age_range",
                percent: 0,
                viewType: .RANGE_SEEK_BAR,
                ansfers: ["18", "90"]
            )
        )

        return list
    }

    func getFreeTimeQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "hobby",
                percent: 7,
                viewType: .MULTY_SELECT,
                ansfers: ["music", "dancing", "stand_up"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "types_of_sports",
                percent: 8,
                viewType: .MULTY_SELECT,
                ansfers: ["badminton", "basketball", "baseball", "billiards", "boxing", "wrestling", "bowling", "cycling", "volleyball", "gymnastics", "golf", "rowing", "darts", "skating"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "evening_time",
                percent: 7,
                viewType: .SINGLE_SELECT,
                ansfers: ["walking_around_the_city"]
            )
        )

        return list
    }

    func getAboutQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "tell_us_about_yourself_what_you_find_interesting",
                percent: 7
            )
        )

        return list
    }

    func getConfirmationQuestions() -> [QuestionInfo] {
        var list: [QuestionInfo] = []
        list.append(
            QuestionInfo(
                id: 0,
                question: "photo",
                percent: 0,
                viewType: .CONFIRMATION_SELECT,
                selectedAnsfer: "your_photo_is_confirmed"
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "email",
                percent: 0,
                viewType: .CONFIRMATION_EMAIL,
                ansfers: ["your_email_has_not_been_confirmed"],
                selectedAnsfer: ""
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "social_network",
                percent: 0,
                viewType: .CONFIRMATION_SOCIAL,
                ansfers: ["the_questionnaire_has_not_been_confirmed"]
            )
        )
        list.append(
            QuestionInfo(
                id: 3,
                question: "phone_number",
                percent: 0,
                viewType: .CONFIRMATION_PHONE,
                ansfers: ["your_phone_number_has_not_been_confirmed"],
                selectedAnsfer: ""
            )
        )

        return list
    }

    func getPageByNumber(number: Int) -> QuestionnairePage {
        pages.first(where: { $0.number == number } ) ??
        QuestionnairePage(number: 0, title: "", type: .SELECT)
    }

    func toNextPage(topPage: PageStates, bottomPage: PageStates, pageInBack: PageStates?) {
        topPage.moveToNextPageState()
        bottomPage.moveToCurrentPageState()
        if pageInBack != nil { pageInBack?.moveFromCurrentPageState() }
    }

    func toPreviousPage(currentPage: PageStates, previousPage: PageStates, backPage: PageStates?) {
        currentPage.moveFromCurrentPageState()
        previousPage.moveToPreviousPageState()
        if backPage != nil { backPage?.hidePageState() }
    }

    func clearData() {
        _ = self.getPageList()
        self.setPageStates()
        self.startAgeRange = 5
        self.endAgeRange = 120
        self.progress = 0
        self.firstSurprize = false
        self.finalSurprize = false
        self.title = "let_s_start"
    }
}

struct QuestionnairePage {
    var number: Int
    var title: String
    var type: QuestionnairePageType
    var buttonTitle: String = "next"
    var questions: [QuestionInfo] = []
}

struct QuestionInfo {
    var id: Int
    var question: String = ""
    var percent: Int = 0
    var unitMask: String = ""
    var viewType: QuestionViewType = .SINGLE_SELECT
    var ansfers: [String] = []
    var selectedAnsfer: String = ""

    var selectAction: ((String) -> Void)? = nil
}

enum QuestionnairePageType {
    case SELECT
    case INPUT
}

enum QuestionViewType {
    case SINGLE_SELECT
    case MULTY_SELECT
    case SEEK_BAR_SELECT
    case SEARCH_SELECT
    case RANGE_SEEK_BAR
    case CONFIRMATION_SELECT
    case CONFIRMATION_EMAIL
    case CONFIRMATION_PHONE
    case CONFIRMATION_SOCIAL
}

class PageStates: ObservableObject {

    private let startZoom: CGFloat = 0.95
    private let startOffset: CGSize = CGSize(width: 0, height: 25)

    @Published var offset: CGSize
    @Published var angle: Angle = Angle.zero
    @Published var zoom: CGFloat
    @Published var opacity: CGFloat = 0

    init(offset: CGSize, zoom: CGFloat, opacity: CGFloat) {
        self.offset = offset
        self.opacity = opacity
        self.zoom = zoom
    }

    init(opacity: CGFloat) {
        self.offset = startOffset
        self.opacity = opacity
        self.zoom = startZoom
    }

    init() {
        self.offset = startOffset
        self.zoom = startZoom
    }

    func moveToNextPageState() {
        offset = CGSize(width: -(UIScreen.main.bounds.width * 2), height: -50)
        angle = Angle(degrees: -30)
        opacity = 0
        zoom = 1
    }

    func moveToCurrentPageState() {
        offset = CGSize.zero
        angle = Angle.zero
        opacity = 1
        zoom = 1
    }

    func moveToPreviousPageState() {
        offset = CGSize.zero
        angle = Angle.zero
        opacity = 1
        zoom = 1
    }

    func moveFromCurrentPageState() {
        offset = startOffset
        angle = Angle.zero
        opacity = 0.5
        zoom = startZoom
    }

    func hidePageState() {
        offset = startOffset
        angle = Angle.zero
        opacity = 0
        zoom = startZoom
    }
}
