//
//  DateUtils.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import Foundation

class DateUtils {
    func getZodiacSignByDate(birthdate: String) -> String {
        let date = String(birthdate.prefix(10).suffix(5))

        if ZodiacSigns.aries.isThisZodiac(day: date) { return ZodiacSigns.aries.rawValue }
        else if ZodiacSigns.taurus.isThisZodiac(day: date) { return ZodiacSigns.taurus.rawValue }
        else if ZodiacSigns.gemini.isThisZodiac(day: date) { return ZodiacSigns.gemini.rawValue }
        else if ZodiacSigns.cancer.isThisZodiac(day: date) { return ZodiacSigns.cancer.rawValue }
        else if ZodiacSigns.leo.isThisZodiac(day: date) { return ZodiacSigns.leo.rawValue }
        else if ZodiacSigns.virgo.isThisZodiac(day: date) { return ZodiacSigns.virgo.rawValue }
        else if ZodiacSigns.libra.isThisZodiac(day: date) { return ZodiacSigns.libra.rawValue }
        else if ZodiacSigns.scorpio.isThisZodiac(day: date) { return ZodiacSigns.scorpio.rawValue }
        else if ZodiacSigns.sagittarius.isThisZodiac(day: date) { return ZodiacSigns.sagittarius.rawValue }
        else if ZodiacSigns.aquarius.isThisZodiac(day: date) { return ZodiacSigns.aquarius.rawValue }
        else if ZodiacSigns.pisces.isThisZodiac(day: date) { return ZodiacSigns.pisces.rawValue }
        else { return ZodiacSigns.capricorn.rawValue }
    }
}

enum ZodiacSigns: String {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces

    var start: String {
        switch self {
        case .aries: return "03-21"
        case .taurus: return "04-21"
        case .gemini: return "05-22"
        case .cancer: return "06-22"
        case .leo: return "07-23"
        case .virgo: return "08-24"
        case .libra: return "09-23"
        case .scorpio: return "10-24"
        case .sagittarius: return "11-23"
        case .capricorn: return "12-22"
        case .aquarius: return "01-21"
        case .pisces: return "02-19"
        }
    }

    var end: String {
        switch self {
        case .aries: return "04-20"
        case .taurus: return "05-21"
        case .gemini: return "06-21"
        case .cancer: return "07-22"
        case .leo: return "08-23"
        case .virgo: return "09-22"
        case .libra: return "10-23"
        case .scorpio: return "11-22"
        case .sagittarius: return "12-21"
        case .capricorn: return "01-20"
        case .aquarius: return "02-18"
        case .pisces: return "03-20"
        }
    }

    func isThisZodiac(day: String) -> Bool {
        if self == .capricorn {
            return day >= self.start || day <= self.end
        } else {
            return day >= self.start && day <= self.end
        }
    }
}

/*
 Овен 21 марта – 20 апреля

 Телец 21 апреля – 21 мая

 Близнецы 22 мая – 21 июня

 Рак 22 июня – 22 июля

 Лев 23 июля – 23 августа

 Дева 24 августа – 22 сентября

 Весы 23 сентября – 23 октября

 Скорпион 24 октября – 22 ноября

 Стрелец 23 ноября – 21 декабря

 Козерог 22 декабря – 20 января

 Водолей 21 января – 18 февраля

 Рыбы 19 февраля – 20 марта


 */
