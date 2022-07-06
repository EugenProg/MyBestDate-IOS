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

    @Published var progress: Int = 0
    @Published var firstSurprize: Bool = false
    @Published var finalSurprize: Bool = false
    @Published var title: String = "let_s_start"
    @Published var pages: [QuestionnairePage] = []

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
            QuestionnairePage(number: 5, title: "about_me", type: .INPUT, questions: getAboutQuestions()),
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
                percent: 3,
                ansfers: ["married", "divorced", "single", "it_s_complicated", "in_love", "engaged", "actively_searching"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "having_kids",
                percent: 4,
                ansfers: ["no", "one", "two", "three", "four", "five_or_more"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "plase_of_residence",
                percent: 2,
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
                percent: 5,
                ansfers: ["no_education", "secondary", "higher"]
            )
        )
        list.append(
            QuestionInfo(
                id: 4,
                question: "occupational_status",
                percent: 3,
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
                percent: 5,
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
                id: 3,
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
                percent: 6,
                viewType: .SINGLE_SELECT,
                ansfers: ["having_a_fun", "interesting_communication", "serious_relationship_only", "one_time_sex"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "search_location",
                percent: 5,
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
                percent: 4,
                viewType: .MULTY_SELECT,
                ansfers: ["music", "dancing", "stand_up"]
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "types_of_sports",
                percent: 5,
                viewType: .MULTY_SELECT,
                ansfers: ["badminton", "basketball", "baseball", "billiards", "boxing", "wrestling", "bowling", "cycling", "volleyball", "gymnastics", "golf", "rowing", "darts", "skating"]
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "evening_time",
                percent: 3,
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
                percent: 5
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
                percent: 6,
                viewType: .CONFIRMATION_SELECT,
                selectedAnsfer: "your_photo_is_confirmed"
            )
        )
        list.append(
            QuestionInfo(
                id: 1,
                question: "email",
                percent: 4,
                viewType: .CONFIRMATION_SELECT,
                ansfers: ["your_email_has_not_been_confirmed"],
                selectedAnsfer: RegistrationMediator.shared.email
            )
        )
        list.append(
            QuestionInfo(
                id: 2,
                question: "social_network",
                percent: 5,
                viewType: .CONFIRMATION_SELECT,
                ansfers: ["the_questionnaire_has_not_been_confirmed"]
            )
        )
        list.append(
            QuestionInfo(
                id: 3,
                question: "phone_number",
                percent: 1,
                viewType: .CONFIRMATION_SELECT,
                ansfers: ["your_phone_number_has_not_been_confirmed"],
                selectedAnsfer: RegistrationMediator.shared.phone
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
