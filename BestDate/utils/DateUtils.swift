//
//  DateUtils.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import Foundation

class DateUtils {
    func getZodiacSignByDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)

        var zodiak: ZodiacSigns = .aries

        if date.isBetween("\(year)-03-21".toShortDate(), "\(year)-04-20".toShortDate()) { zodiak = .aries }
        if date.isBetween("\(year)-04-21".toShortDate(), "\(year)-05-21".toShortDate()) { zodiak = .taurus }
        if date.isBetween("\(year)-05-22".toShortDate(), "\(year)-06-21".toShortDate()) { zodiak = .gemini }
        if date.isBetween("\(year)-06-22".toShortDate(), "\(year)-07-22".toShortDate()) { zodiak = .cancer }
        if date.isBetween("\(year)-07-23".toShortDate(), "\(year)-08-23".toShortDate()) { zodiak = .leo }
        if date.isBetween("\(year)-08-24".toShortDate(), "\(year)-09-22".toShortDate()) { zodiak = .virgo }
        if date.isBetween("\(year)-09-23".toShortDate(), "\(year)-10-23".toShortDate()) { zodiak = .libra }
        if date.isBetween("\(year)-10-24".toShortDate(), "\(year)-11-22".toShortDate()) { zodiak = .scorpio }
        if date.isBetween("\(year)-11-23".toShortDate(), "\(year)-12-21".toShortDate()) { zodiak = .sagittarius }
        if date.isBetween("\(year)-12-22".toShortDate(), "\(year)-01-20".toShortDate()) { zodiak = .capricorn }
        if date.isBetween("\(year)-01-21".toShortDate(), "\(year)-02-18".toShortDate()) { zodiak = .aquarius }
        if date.isBetween("\(year)-02-19".toShortDate(), "\(year)-03-20".toShortDate()) { zodiak = .pisces }

        return zodiak.rawValue
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
