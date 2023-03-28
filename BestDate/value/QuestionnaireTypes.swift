//
//  QuestionnaireTypes.swift
//  BestDate
//
//  Created by Евгений on 05.10.2022.
//

import Foundation

protocol QuestionnaireType {
    func getName(_ name: String?) -> String
    func getServerName(_ answer: String?) -> String?
    func getNameKey(_ name: String?) -> String
}

protocol QuestionnaireArrayType {
    func getNameLine(_ names: [String?]?) -> String
    func getNameArray(_ names: [String?]?) -> [String]?
    func getServerArray(_ answers: [String?]?) -> [String]?
    func getServerName(_ answer: String?) -> String
}

class MaritalStatus: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Married": return "married"
        case "Divorced": return "divorced"
        case "Single": return "single"
        case "it's complicated": return "it_s_complicated"
        case "In love": return "in_love"
        case "Engaged": return "engaged"
        case "Actively searching": return "actively_searching"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "married": return "Married"
        case "divorced": return "Divorced"
        case "single": return "Single"
        case "it_s_complicated": return "it's complicated"
        case "in_love": return "In love"
        case "engaged": return "Engaged"
        case "actively_searching": return "Actively searching"
        default: return nil
        }
    }
}

class KidsCount: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "No": return "no_kids"
        case "1": return "one"
        case "2": return "two"
        case "3": return "three"
        case "4": return "four"
        case "5 or more": return "five_or_more"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "no_kids": return "No"
        case "one": return "1"
        case "two": return "2"
        case "three": return "3"
        case "four": return "4"
        case "five_or_more": return "5 or more"
        default: return nil
        }
    }
}

class EducationStatus: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "No education": return "no_education"
        case "Secondary": return "secondary"
        case "Higher": return "higher"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "no_education": return "No education"
        case "secondary": return "Secondary"
        case "higher": return "Higher"
        default: return nil
        }
    }
}

class OccupationalStatus: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Student": return "student"
        case "Working": return "working"
        case "Unemployed": return "unemployed"
        case "Businessman": return "businessman"
        case "Looking for myself": return "looking_for_my_self"
        case "Freelancer": return "freelancer"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "student": return "Student"
        case "working": return "Working"
        case "unemployed": return "Unemployed"
        case "businessman": return "Businessman"
        case "looking_for_my_self": return "Looking for myself"
        case "freelancer": return "Freelancer"
        default: return nil
        }
    }
}

class HeirColorType: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Blond": return "blond"
        case "Brunette": return "brunette"
        case "Redhead": return "redhead"
        case "No hair": return "no_hair"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "blond": return "Blond"
        case "brunette": return "Brunette"
        case "redhead": return "Redhead"
        case "no_hair": return "No hair"
        default: return nil
        }
    }
}

class HeirLengthType: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Short": return "short_"
        case "Medium": return "medium"
        case "Long": return "long_"
        case "No hair": return "no_hair"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "short_": return "Short"
        case "medium": return "Medium"
        case "long_": return "Long"
        case "no_hair": return "No hair"
        default: return nil
        }
    }
}

class EyeColorType: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Blue": return "blue"
        case "Gray": return "gray"
        case "Green": return "green"
        case "Brown-yellow": return "brown_yellow"
        case "Yellow": return "yellow"
        case "Brown": return "brown"
        case "Black": return "black"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "blue": return "Blue"
        case "gray": return "Gray"
        case "green": return "Green"
        case "brown_yellow": return "Brown-yellow"
        case "yellow": return "Yellow"
        case "brown": return "Brown"
        case "black": return "Black"
        default: return nil
        }
    }
}

class PorposeOfDatingType: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Friendship": return "friendship"
        case "Love": return "love"
        case "Communication": return "communication"
        case "Serious relationship": return "serious_relationship"
        case "Sex": return "sex"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "friendship": return "Friendship"
        case "love": return "Love"
        case "communication": return "Communication"
        case "serious_relationship": return "Serious relationship"
        case "sex": return "Sex"
        default: return nil
        }
    }
}

class AwaitFromDatingType: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Having a fun": return "having_a_fun"
        case "Interesting communication": return "interesting_communication"
        case "Serious relationship only": return "serious_relationship_only"
        case "One time sex": return "one_time_sex"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "having_a_fun": return "Having a fun"
        case "interesting_communication": return "Interesting communication"
        case "serious_relationship_only": return "Serious relationship only"
        case "one_time_sex": return "One time sex"
        default: return nil
        }
    }
}

class HobbyType: QuestionnaireArrayType {
    func getServerName(_ answer: String?) -> String {
        switch answer {
        case "music": return "Music"
        case "dancing": return "Dancing"
        case "stand_up": return "Stand up"
        case "fishing": return "Fishing"
        case "diggering": return "Diggering"
        case "hunting": return "Hunting"
        case "blogging": return "Blogging"
        case "hike": return "Hike"
        case "quest": return "Quest"
        case "gardening": return "Gardening"
        case "watching_movies": return "Watching movies"
        case "bike": return "Bike"
        case "nature_watching": return "Nature Watching"
        case "spotting": return "Spotting"
        case "sailing": return "Sailing"
        case "rap": return "Rap"
        case "road_trips": return "Road trips"
        case "pickup": return "Pick-up"
        case "sauna": return "Bath or sauna"
        case "radio": return "Radio amateurism"
        default: return ""
        }
    }

    func getNameLine(_ names: [String?]?) -> String {
        if names?.isEmpty == true { return "" }
        var result = ""
        for item in getNameArray(names) ?? [] {
            result += "\(item.localized()), "
        }
        if !result.isEmpty {
            return String(result.prefix(result.count - 2))
        }

        return result
    }

    func getNameArray(_ names: [String?]?) -> [String]? {
        var list: [String] = []
        for type in names ?? [] {
            switch type {
            case "Music": list.append("music")
            case "Dancing": list.append("dancing")
            case "Stand up": list.append("stand_up")
            case "Fishing": list.append("fishing")
            case "Diggering": list.append("diggering")
            case "Hunting": list.append("hunting")
            case "Blogging": list.append("blogging")
            case "Hike": list.append("hike")
            case "Quest": list.append("quest")
            case "Gardening": list.append("gardening")
            case "Watching movies": list.append("watching_movies")
            case "Bike": list.append("bike")
            case "Nature Watching": list.append("nature_watching")
            case "Spotting": list.append("spotting")
            case "Sailing": list.append("sailing")
            case "Rap": list.append("rap")
            case "Road trips": list.append("road_trips")
            case "Pick-up": list.append("pickup")
            case "Bath or sauna": list.append("sauna")
            case "Radio amateurism": list.append("radio")
            default: do {}
            }
        }
        return list
    }

    func getServerArray(_ answers: [String?]?) -> [String]? {
        var serverArray: [String] = []

        if answers?.isEmpty == true { return nil }

        for item in answers ?? [] {
            if item != nil {
                serverArray.append(getServerName(item))
            }
        }

        return serverArray
    }
}

class SportTypes: QuestionnaireArrayType {
    func getServerName(_ answer: String?) -> String {
        switch answer {
        case "badminton": return "Badminton"
        case "basketball": return "Basketball"
        case "baseball": return "Baseball"
        case "billiards": return "Billiards"
        case "boxing": return "Boxing"
        case "wrestling": return "Wrestling"
        case "bowling": return "Bowling"
        case "cycling": return "Cycling"
        case "volleyball": return "Volleyball"
        case "gymnastics": return "Gymnastics"
        case "golf": return "Golf"
        case "rowing": return "Rowing"
        case "darts": return "Darts"
        case "skating": return "Skating"
        case "karate": return "Karate"
        case "tennis": return "Tennis"
        case "swimming": return "Swimming"
        case "judo": return "Judo"
        case "climbing": return "Climbing"
        case "soccer": return "Soccer"
        case "chess": return "Chess"
        case "checkers": return "Checkers"
        default: return ""
        }
    }

    func getNameLine(_ names: [String?]?) -> String {
        if names?.isEmpty == true { return "" }
        var result = ""
        for item in getNameArray(names) ?? [] {
            result += "\(item.localized()), "
        }
        if !result.isEmpty {
            return String(result.prefix(result.count - 2))
        }

        return result
    }

    func getNameArray(_ names: [String?]?) -> [String]? {
        var list: [String] = []
        for type in names ?? [] {
            switch type {
            case "Badminton": list.append("badminton")
            case "Basketball": list.append("basketball")
            case "Baseball": list.append("baseball")
            case "Billiards": list.append("billiards")
            case "Boxing": list.append("boxing")
            case "Wrestling": list.append("wrestling")
            case "Bowling": list.append("bowling")
            case "Cycling": list.append("cycling")
            case "Volleyball": list.append("volleyball")
            case "Gymnastics": list.append("gymnastics")
            case "Golf": list.append("golf")
            case "Rowing": list.append("rowing")
            case "Darts": list.append("darts")
            case "Skating": list.append("skating")
            case "Karate": list.append("karate")
            case "Tennis": list.append("tennis")
            case "Swimming": list.append("swimming")
            case "Judo": list.append("judo")
            case "Climbing": list.append("climbing")
            case "Soccer": list.append("soccer")
            case "Chess": list.append("chess")
            case "Checkers": list.append("checkers")
            default: do {}
            }
        }

        return list
    }

    func getServerArray(_ answers: [String?]?) -> [String]? {
        var serverArray: [String] = []

        if answers?.isEmpty == true { return nil }

        for item in answers ?? [] {
            if item != nil {
                serverArray.append(getServerName(item))
            }
        }

        return serverArray
    }
}

class EveningTimeTypes: QuestionnaireType {
    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Walking around the city": return "walking_around_the_city"
        case "Sitting in Bestdate": return "sitting_in_best_date"
        case "Going on dates": return "going_on_dates"
        case "Netflix": return "netflix"
        case "Youtube": return "youtube"
        case "Meditating": return "meditating"
        default: return ""
        }
    }

    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "walking_around_the_city": return "Walking around the city"
        case "sitting_in_best_date": return "Sitting in Bestdate"
        case "going_on_dates": return "Going on dates"
        case "netflix": return "Netflix"
        case "youtube": return "Youtube"
        case "meditating": return "Meditating"
        default: return nil
        }
    }
}

class NationalityTypes: QuestionnaireType {
    func getName(_ name: String?) -> String {
        getNameKey(name).localized()
    }

    func getServerName(_ answer: String?) -> String? {
        switch answer {
        case "AB": return "Abkhazia"
        case "AU": return "Australia"
        case "AT": return "Austria"
        case "AZ": return "Azerbaijan"
        case "AL": return "Albania"
        case "DZ": return "Algeria"
        case "AS": return "American Samoa"
        case "AI": return "Anguilla"
        case "AO": return "Angola"
        case "AD": return "Andorra"
        case "AR": return "Antigua and Barbuda"
        case "AG": return "Argentina"
        case "AM": return "Armenia"
        case "AW": return "Aruba"
        case "AF": return "Afghanistan"
        case "BS": return "Bahamas"
        case "BD": return "Bangladesh"
        case "BB": return "Barbados"
        case "BH": return "Bahrain"
        case "BY": return "Belarus"
        case "BZ": return "Belize"
        case "BE": return "Belgium"
        case "BJ": return "Benin"
        case "BM": return "Bermuda"
        case "BG": return "Bulgaria"
        case "BO": return "Bolivia"
        case "BQ": return "Bonaire"
        case "BA": return "Bosnia and Herzegovina"
        case "BW": return "Botswana"
        case "BR": return "Brazil"
        case "IO": return "British Indian Ocean Territory"
        case "BN": return "Brunei Darussalam"
        case "BF": return "Burkina Faso"
        case "BI": return "Burundi"
        case "BT": return "Bhutan"
        case "VU": return "Vanuatu"
        case "HU": return "Hungary"
        case "VE": return "Venezuela"
        case "VG": return "Virgin Islands, British"
        case "VI": return "Virgin Islands, U.S."
        case "VN": return "Vietnam"
        case "GA": return "Gabon"
        case "HT": return "Haiti"
        case "GY": return "Guyana"
        case "GM": return "Gambia"
        case "GH": return "Ghana"
        case "GP": return "Guadeloupe"
        case "GT": return "Guatemala"
        case "GN": return "Guinea"
        case "GW": return "Guinea-Bissau"
        case "DE": return "Germany"
        case "GG": return "Guernsey"
        case "GI": return "Gibraltar"
        case "HN": return "Honduras"
        case "HK": return "Hong Kong"
        case "GD": return "Grenada"
        case "GL": return "Greenland"
        case "GR": return "Greece"
        case "GE": return "Georgia"
        case "GU": return "Guam"
        case "DK": return "Denmark"
        case "JE": return "Jerse"
        case "DJ": return "Djibouti"
        case "DM": return "Dominica"
        case "DO": return "Dominican Republic"
        case "EG": return "Egypt"
        case "ZM": return "Zambia"
        case "EH": return "Western Sahara"
        case "ZW": return "Zimbabwe"
        case "IL": return "Israel"
        case "IN": return "India"
        case "ID": return "Indonesia"
        case "JO": return "Jordan"
        case "IQ": return "Iraq"
        case "IE": return "Ireland"
        case "IS": return "Iceland"
        case "ES": return "Spain"
        case "IT": return "Italy"
        case "YE": return "Yemen"
        case "CV": return "Cape Verde"
        case "KZ": return "Kazakhstan"
        case "KH": return "Cambodia"
        case "CM": return "Cameroon"
        case "CA": return "Canada"
        case "QA": return "Qatar"
        case "KE": return "Kenya"
        case "CY": return "Cyprus"
        case "KG": return "Kyrgyzstan"
        case "KI": return "Kiribati"
        case "CN": return "China"
        case "CC": return "Cocos (Keeling) Islands"
        case "CO": return "Colombia"
        case "KM": return "Comoros"
        case "CG": return "Congo"
        case "CD": return "Congo, Democratic Republic of the"
        case "KP": return "Korea, Democratic People's republic of"
        case "KR": return "Korea, Republic of"
        case "CR": return "Costa Rica"
        case "CI": return "Cote d'Ivoire"
        case "CU": return "Cuba"
        case "KW": return "Kuwait"
        case "CW": return "Curaçao"
        case "LA": return "Lao People's Democratic Republic"
        case "LV": return "Latvia"
        case "LS": return "Lesotho"
        case "LB": return "Lebanon"
        case "LY": return "Libyan Arab Jamahiriya"
        case "LR": return "Liberia"
        case "LI": return "Liechtenstein"
        case "LT": return "Lithuania"
        case "LU": return "Luxembourg"
        case "MU": return "Mauritius"
        case "MR": return "Mauritania"
        case "MG": return "Madagascar"
        case "YT": return "Mayotte"
        case "MO": return "Macao"
        case "MW": return "Malawi"
        case "MY": return "Malaysia"
        case "ML": return "Mali"
        case "UM": return "United States Minor Outlying Islands"
        case "MV": return "Maldives"
        case "MT": return "Malta"
        case "MA": return "Morocco"
        case "MQ": return "Martinique"
        case "MH": return "Marshall Islands"
        case "MX": return "Mexico"
        case "FM": return "Micronesia, Federated States of"
        case "MZ": return "Mozambique"
        case "MD": return "Moldova"
        case "MC": return "Monaco"
        case "MN": return "Mongolia"
        case "MS": return "Montserrat"
        case "MM": return "Burma"
        case "NA": return "Namibia"
        case "NR": return "Nauru"
        case "NP": return "Nepal"
        case "NE": return "Niger"
        case "NG": return "Nigeria"
        case "NL": return "Netherlands"
        case "NI": return "Nicaragua"
        case "NU": return "Niu"
        case "NZ": return "New Zealand"
        case "NC": return "New Caledonia"
        case "NO": return "Norway"
        case "AE": return "United Arab Emirates"
        case "OM": return "Oman"
        case "BV": return "Bouvet Island"
        case "IM": return "Isle of Man"
        case "NF": return "Norfolk Island"
        case "CX": return "Christmas Island"
        case "HM": return "Heard Island and McDonald Islands"
        case "KY": return "Cayman Islands"
        case "CK": return "Cook Islands"
        case "TC": return "Turks and Caicos Islands"
        case "PK": return "Pakistan"
        case "PW": return "Palau"
        case "PA": return "Panama"
        case "VA": return "Holy See (Vatican City State)"
        case "PG": return "Papua New Guinea"
        case "PY": return "Paraguay"
        case "PE": return "Peru"
        case "PN": return "Pitcairn"
        case "PL": return "Poland"
        case "PT": return "Portugal"
        case "PR": return "Puerto Rico"
        case "MK": return "Macedonia, The Former Yugoslav Republic Of"
        case "RE": return "Reunion"
        case "RU": return "Russian Federation"
        case "RW": return "Rwanda"
        case "RO": return "Romania"
        case "WS": return "Samoa"
        case "SM": return "San Marino"
        case "ST": return "Sao Tome and Principe"
        case "SA": return "Saudi Arabia"
        case "SH": return "Saint Helena, Ascension And Tristan Da Cunha"
        case "MP": return "Northern Mariana Islands"
        case "BL": return "Saint Barthélemy"
        case "MF": return "Saint Martin (French Part)"
        case "SN": return "Senegal"
        case "VC": return "Saint Vincent and the Grenadines"
        case "KN": return "Saint Kitts and Nevis"
        case "LC": return "Saint Lucia"
        case "PM": return "Saint Pierre and Miquelon"
        case "RS": return "Serbia"
        case "SC": return "Seychelles"
        case "SG": return "Singapore"
        case "SX": return "Sint Maarten"
        case "SY": return "Syrian Arab Republic"
        case "SK": return "Slovakia"
        case "SI": return "Slovenia"
        case "GB": return "United Kingdom"
        case "US": return "United States"
        case "SB": return "Solomon Islands"
        case "SO": return "Somalia"
        case "SD": return "Sudan"
        case "SR": return "Suriname"
        case "SL": return "Sierra Leone"
        case "TJ": return "Tajikistan"
        case "TH": return "Thailand"
        case "TW": return "Taiwan"
        case "TZ": return "Tanzania, United Republic Of"
        case "TL": return "Timor-Leste"
        case "TG": return "Togo"
        case "TK": return "Tokelau"
        case "TO": return "Tonga"
        case "TT": return "Trinidad and Tobago"
        case "TV": return "Tuvalu"
        case "TN": return "Tunisia"
        case "TM": return "Turkmenistan"
        case "TR": return "Turkey"
        case "UG": return "Uganda"
        case "UZ": return "Uzbekistan"
        case "UA": return "Ukraine"
        case "WF": return "Wallis and Futuna"
        case "UY": return "Uruguay"
        case "FO": return "Faroe Islands"
        case "FJ": return "Fiji"
        case "PH": return "Philippines"
        case "FI": return "Finland"
        case "FK": return "Falkland Islands (Malvinas)"
        case "FR": return "France"
        case "GF": return "French Guiana"
        case "PF": return "French Polynesia"
        case "TF": return "French Southern Territories"
        case "HR": return "Croatia"
        case "CF": return "Central African Republic"
        case "TD": return "Chad"
        case "ME": return "Montenegro"
        case "CZ": return "Czech Republic"
        case "CL": return "Chile"
        case "CH": return "Switzerland"
        case "SE": return "Sweden"
        case "SJ": return "Svalbard and Jan Mayen"
        case "LK": return "Sri Lanka"
        case "EC": return "Ecuador"
        case "GQ": return "Equatorial Guinea"
        case "AX": return "Åland Islands"
        case "SV": return "El Salvador"
        case "ER": return "Eritrea"
        case "SZ": return "Eswatini"
        case "EE": return "Estonia"
        case "ET": return "Ethiopia"
        case "ZA": return "South Africa"
        case "GS": return "South Georgia and the South Sandwich Islands"
        case "OS": return "South Ossetia"
        case "SS": return "South Sudan"
        case "JM": return "Jamaica"
        case "JP": return "Japan"
        default: return nil
        }
    }

    func getNameKey(_ name: String?) -> String {
        switch name {
        case "Abkhazia": return "AB"
        case "Australia": return "AU"
        case "Austria": return "AT"
        case "Azerbaijan": return "AZ"
        case "Albania": return "AL"
        case "Algeria": return "DZ"
        case "American Samoa": return "AS"
        case "Anguilla": return "AI"
        case "Angola": return "AO"
        case "Andorra": return "AD"
        case "Antigua and Barbuda": return "AR"
        case "Argentina": return "AG"
        case "Armenia": return "AM"
        case "Aruba": return "AW"
        case "Afghanistan": return "AF"
        case "Bahamas": return "BS"
        case "Bangladesh": return "BD"
        case "Barbados": return "BB"
        case "Bahrain": return "BH"
        case "Belarus": return "BY"
        case "Belize": return "BZ"
        case "Belgium": return "BE"
        case "Benin": return "BJ"
        case "Bermuda": return "BM"
        case "Bulgaria": return "BG"
        case "Bolivia": return "BO"
        case "Bonaire": return "BQ"
        case "Bosnia and Herzegovina": return "BA"
        case "Botswana": return "BW"
        case "Brazil": return "BR"
        case "British Indian Ocean Territory": return "IO"
        case "Brunei Darussalam": return "BN"
        case "Burkina Faso": return "BF"
        case "Burundi": return "BI"
        case "Bhutan": return "BT"
        case "Vanuatu": return "VU"
        case "Hungary": return "HU"
        case "Venezuela": return "VE"
        case "Virgin Islands, British": return "VG"
        case "Virgin Islands, U.S.": return "VI"
        case "Vietnam": return "VN"
        case "Gabon": return "GA"
        case "Haiti": return "HT"
        case "Guyana": return "GY"
        case "Gambia": return "GM"
        case "Ghana": return "GH"
        case "Guadeloupe": return "GP"
        case "Guatemala": return "GT"
        case "Guinea": return "GN"
        case "Guinea-Bissau": return "GW"
        case "Germany": return "DE"
        case "Guernsey": return "GG"
        case "Gibraltar": return "GI"
        case "Honduras": return "HN"
        case "Hong Kong": return "HK"
        case "Grenada": return "GD"
        case "Greenland": return "GL"
        case "Greece": return "GR"
        case "Georgia": return "GE"
        case "Guam": return "GU"
        case "Denmark": return "DK"
        case "Jerse": return "JE"
        case "Djibouti": return "DJ"
        case "Dominica": return "DM"
        case "Dominican Republic": return "DO"
        case "Egypt": return "EG"
        case "Zambia": return "ZM"
        case "Western Sahara": return "EH"
        case "Zimbabwe": return "ZW"
        case "Israel": return "IL"
        case "India": return "IN"
        case "Indonesia": return "ID"
        case "Jordan": return "JO"
        case "Iraq": return "IQ"
        case "Ireland": return "IE"
        case "Iceland": return "IS"
        case "Spain": return "ES"
        case "Italy": return "IT"
        case "Yemen": return "YE"
        case "Cape Verde": return "CV"
        case "Kazakhstan": return "KZ"
        case "Cambodia": return "KH"
        case "Cameroon": return "CM"
        case "Canada": return "CA"
        case "Qatar": return "QA"
        case "Kenya": return "KE"
        case "Cyprus": return "CY"
        case "Kyrgyzstan": return "KG"
        case "Kiribati": return "KI"
        case "China": return "CN"
        case "Cocos (Keeling) Islands": return "CC"
        case "Colombia": return "CO"
        case "Comoros": return "KM"
        case "Congo": return "CG"
        case "Congo, Democratic Republic of the": return "CD"
        case "Korea, Democratic People's republic of": return "KP"
        case "Korea, Republic of": return "KR"
        case "Costa Rica": return "CR"
        case "Cote d'Ivoire": return "CI"
        case "Cuba": return "CU"
        case "Kuwait": return "KW"
        case "Curaçao": return "CW"
        case "Lao People's Democratic Republic": return "LA"
        case "Latvia": return "LV"
        case "Lesotho": return "LS"
        case "Lebanon": return "LB"
        case "Libyan Arab Jamahiriya": return "LY"
        case "Liberia": return "LR"
        case "Liechtenstein": return "LI"
        case "Lithuania": return "LT"
        case "Luxembourg": return "LU"
        case "Mauritius": return "MU"
        case "Mauritania": return "MR"
        case "Madagascar": return "MG"
        case "Mayotte": return "YT"
        case "Macao": return "MO"
        case "Malawi": return "MW"
        case "Malaysia": return "MY"
        case "Mali": return "ML"
        case "United States Minor Outlying Islands": return "UM"
        case "Maldives": return "MV"
        case "Malta": return "MT"
        case "Morocco": return "MA"
        case "Martinique": return "MQ"
        case "Marshall Islands": return "MH"
        case "Mexico": return "MX"
        case "Micronesia, Federated States of": return "FM"
        case "Mozambique": return "MZ"
        case "Moldova": return "MD"
        case "Monaco": return "MC"
        case "Mongolia": return "MN"
        case "Montserrat": return "MS"
        case "Burma": return "MM"
        case "Namibia": return "NA"
        case "Nauru": return "NR"
        case "Nepal": return "NP"
        case "Niger": return "NE"
        case "Nigeria": return "NG"
        case "Netherlands": return "NL"
        case "Nicaragua": return "NI"
        case "Niu": return "NU"
        case "New Zealand": return "NZ"
        case "New Caledonia": return "NC"
        case "Norway": return "NO"
        case "United Arab Emirates": return "AE"
        case "Oman": return "OM"
        case "Bouvet Island": return "BV"
        case "Isle of Man": return "IM"
        case "Norfolk Island": return "NF"
        case "Christmas Island": return "CX"
        case "Heard Island and McDonald Islands": return "HM"
        case "Cayman Islands": return "KY"
        case "Cook Islands": return "CK"
        case "Turks and Caicos Islands": return "TC"
        case "Pakistan": return "PK"
        case "Palau": return "PW"
        case "Panama": return "PA"
        case "Holy See (Vatican City State)": return "VA"
        case "Papua New Guinea": return "PG"
        case "Paraguay": return "PY"
        case "Peru": return "PE"
        case "Pitcairn": return "PN"
        case "Poland": return "PL"
        case "Portugal": return "PT"
        case "Puerto Rico": return "PR"
        case "Macedonia, The Former Yugoslav Republic Of": return "MK"
        case "Reunion": return "RE"
        case "Russian Federation": return "RU"
        case "Rwanda": return "RW"
        case "Romania": return "RO"
        case "Samoa": return "WS"
        case "San Marino": return "SM"
        case "Sao Tome and Principe": return "ST"
        case "Saudi Arabia": return "SA"
        case "Saint Helena, Ascension And Tristan Da Cunha": return "SH"
        case "Northern Mariana Islands": return "MP"
        case "Saint Barthélemy": return "BL"
        case "Saint Martin (French Part)": return "MF"
        case "Senegal": return "SN"
        case "Saint Vincent and the Grenadines": return "VC"
        case "Saint Kitts and Nevis": return "KN"
        case "Saint Lucia": return "LC"
        case "Saint Pierre and Miquelon": return "PM"
        case "Serbia": return "RS"
        case "Seychelles": return "SC"
        case "Singapore": return "SG"
        case "Sint Maarten": return "SX"
        case "Syrian Arab Republic": return "SY"
        case "Slovakia": return "SK"
        case "Slovenia": return "SI"
        case "United Kingdom": return "GB"
        case "United States": return "US"
        case "Solomon Islands": return "SB"
        case "Somalia": return "SO"
        case "Sudan": return "SD"
        case "Suriname": return "SR"
        case "Sierra Leone": return "SL"
        case "Tajikistan": return "TJ"
        case "Thailand": return "TH"
        case "Taiwan": return "TW"
        case "Tanzania, United Republic Of": return "TZ"
        case "Timor-Leste": return "TL"
        case "Togo": return "TG"
        case "Tokelau": return "TK"
        case "Tonga": return "TO"
        case "Trinidad and Tobago": return "TT"
        case "Tuvalu": return "TV"
        case "Tunisia": return "TN"
        case "Turkmenistan": return "TM"
        case "Turkey": return "TR"
        case "Uganda": return "UG"
        case "Uzbekistan": return "UZ"
        case "Ukraine": return "UA"
        case "Wallis and Futuna": return "WF"
        case "Uruguay": return "UY"
        case "Faroe Islands": return "FO"
        case "Fiji": return "FJ"
        case "Philippines": return "PH"
        case "Finland": return "FI"
        case "Falkland Islands (Malvinas)": return "FK"
        case "France": return "FR"
        case "French Guiana": return "GF"
        case "French Polynesia": return "PF"
        case "French Southern Territories": return "TF"
        case "Croatia": return "HR"
        case "Central African Republic": return "CF"
        case "Chad": return "TD"
        case "Montenegro": return "ME"
        case "Czech Republic": return "CZ"
        case "Chile": return "CL"
        case "Switzerland": return "CH"
        case "Sweden": return "SE"
        case "Svalbard and Jan Mayen": return "SJ"
        case "Sri Lanka": return "LK"
        case "Ecuador": return "EC"
        case "Equatorial Guinea": return "GQ"
        case "Åland Islands": return "AX"
        case "El Salvador": return "SV"
        case "Eritrea": return "ER"
        case "Eswatini": return "SZ"
        case "Estonia": return "EE"
        case "Ethiopia": return "ET"
        case "South Africa": return "ZA"
        case "South Georgia and the South Sandwich Islands": return "GS"
        case "South Ossetia": return "OS"
        case "South Sudan": return "SS"
        case "Jamaica": return "JM"
        case "Japan": return "JP"
        default: return ""
        }
    }
}
