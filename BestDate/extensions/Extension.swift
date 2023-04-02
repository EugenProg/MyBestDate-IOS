//
//  Extension.swift
//  BestDate
//
//  Created by Евгений on 06.06.2022.
//

import Foundation
import SwiftUI
import UIKit
import AudioToolbox

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
                .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

struct ShakeEffect: GeometryEffect {
        func effectValue(size: CGSize) -> ProjectionTransform {
            ProjectionTransform(CGAffineTransform(translationX: -8 * sin(position * 2 * .pi), y: 0))
        }
        
        init(shakes: Int) {
            position = CGFloat(shakes)
        }
        
        var position: CGFloat
        var animatableData: CGFloat {
            get { position }
            set { position = newValue }
        }
    }

extension View {
    func setError(errorState: Binding<Bool>) {
        errorState.wrappedValue = true
        UIDevice.vibrate()
    }
}

extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }

    func toServerDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

    func getZodiacSign() -> String {
        DateUtils().getZodiacSignByDate(date: self).localized()
    }

    func toShortString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }

    func isBetween(_ date1: Date, _ date2: Date) -> Bool {
            date1 < date2
                ? DateInterval(start: date1, end: date2).contains(self)
                : DateInterval(start: date2, end: date1).contains(self)
    }

    static func getEithteenYearsAgoDate() -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .year, value: -18, to: Date())!
        return calendar.date(byAdding: .day, value: -1, to: date)!
    }

    func getVisitPeriod() -> String {
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: self, to: Date.now)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0

        if days > 6 {
            return self.toShortString()
        } else if days > 0 {
            return String.localizedStringWithFormat("was_n_days_ago".localized(), days)
        } else if hours > 0 {
            return String.localizedStringWithFormat("was_n_hours_ago".localized(), hours)
        } else if minutes > 0 {
            return String.localizedStringWithFormat("was_n_min_ago".localized(), minutes)
        } else {
            return ""
        }
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        return dateFormatter.date(from: self) ?? Date.now
    }

    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self.toDate())
    }

    func toShortDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self.toDate())
    }

    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self.toDate())
    }

    func getWeekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: self.toDate())
    }

    func getWeekdayWithTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE HH:mm"
        return formatter.string(from: self.toDate())
    }

    func toShortDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        return dateFormatter.date(from: self) ?? Date.now
    }

    func toInt() -> Int {
        if let str = NumberFormatter().number(from: self) {
            return Int(truncating: str)
        }
        return 0
    }

    func toFloat() -> CGFloat {
        if let str = NumberFormatter().number(from: self) {
            return CGFloat(truncating: str)
        }
        return 0
    }

    func getLinesHeight(viewVidth: CGFloat, fontSize: CGFloat) -> CGRect {
        self.boundingRect(
                    with: CGSize(
                        width: viewVidth,
                        height: .greatestFiniteMagnitude
                    ),
                    options: .usesLineFragmentOrigin,
                    attributes: [.font: UIFont.systemFont(ofSize: fontSize)],
                    context: nil
                )
    }

    func localized() -> String {
        NSLocalizedString(self, comment: self)
    }

    func getUserFromJson() -> ShortUserInfo? {
        if self.isEmpty { return nil }

        return try? JSONDecoder().decode(ShortUserInfo.self, from: self.data(using: .utf8)!)
    }
}

extension Int {
    func toString() -> String {
        String(self)
    }
}

extension Double {
    func toString() -> String {
        String(self)
    }

    func printPercent() -> String {
        String(format: "%.1f", self)
    }
}

extension UserInfo {
    func getMainPhoto() -> ProfileImage? {
        for image in self.photos ?? [] {
            if image.main == true {
                return image
            }
        }
        return self.photos?.first
    }

    func getAge() -> Int {
        Calendar.current.dateComponents([.year], from: self.birthday?.toDate() ?? Date.now, to: Date.now).year ?? 0
    }

    func getCoins() -> Int {
        (self.coins ?? "0").toInt()
    }

    func getDistance() -> String {
        String.localizedStringWithFormat(
            "disatnce_unit".localized(),
            String(format: "%.0f", self.distance ?? 0.0).localized()
        )
    }

    func getBirthday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"

        let incomingFormatter = DateFormatter()
        incomingFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

        return dateFormatter.string(from: incomingFormatter.date(from: self.birthday ?? "") ?? Date())
    }

    func getBirthday() -> Date {
        let incomingFormatter = DateFormatter()
        incomingFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

        return incomingFormatter.date(from: self.birthday ?? "") ?? Date.getEithteenYearsAgoDate()
    }

    func getLocation() -> String {
        return self.location?.toString() ?? ""
    }

    func toShortUser() -> ShortUserInfo {
        ShortUserInfo(
            id: self.id,
            name: self.name,
            gender: self.gender,
            birthday: self.gender,
            main_photo: self.getMainPhoto(),
            is_online: self.is_online,
            last_online_at: self.last_online_at,
            blocked: self.blocked,
            allow_chat: self.allow_chat,
            full_questionnaire: self.questionnaire?.isFull(),
            distance: self.distance)
    }

    func copy() -> UserInfo {
        UserInfo(
            id: self.id,
            name: self.name,
            email: self.email,
            email_verification: self.email_verification,
            phone: self.phone,
            phone_verification: self.phone_verification,
            gender: self.gender,
            look_for: self.look_for,
            language: self.language,
            birthday: self.birthday,
            is_online: self.is_online,
            last_online_at: self.last_online_at,
            new_likes: self.new_likes,
            new_guests: self.new_guests,
            new_messages: self.new_messages,
            new_invitations: self.new_invitations,
            new_duels: self.new_duels,
            distance: self.distance,
            photos: self.photos,
            location: self.location,
            block_messages: self.block_messages,
            blocked: self.blocked,
            blocked_me: self.blocked_me,
            questionnaire: self.questionnaire
        )
    }

    func getSearchGender() -> FilterGender {
        if self.look_for?.contains("male") == true { return .men }
        else { return .women }
    }
}


extension ShortUserInfo {
    func getAge() -> Int {
        Calendar.current.dateComponents([.year], from: self.birthday?.toDate() ?? Date.now, to: Date.now).year ?? 0
    }

    func getDistance() -> String {
        String.localizedStringWithFormat(
            "disatnce_unit".localized(),
            String(format: "%.0f", self.distance ?? 0.0).localized()
        )
    }

    func getLocation() -> String {
        return self.location?.toString() ?? ""
    }

    func toUser() -> UserInfo {
        UserInfo(
            id: self.id,
            name: self.name,
            gender: self.gender,
            birthday: self.birthday,
            is_online: self.is_online,
            last_online_at: self.last_online_at
        )
    }

    func getRole() -> UserRole {
        switch self.role {
        case "bot": return .bot
        case "user": return .user
        default: return .user
        }
    }
}

extension Location {
    func toString() -> String {
        let country = self.country ?? ""
        let city = self.city ?? ""

        var location = ""
        if !country.isEmpty { location = country }
        if !location.isEmpty && !city.isEmpty {
            location += ", \(city)"
        } else if !city.isEmpty {
            location = city
        }
        return location
    }
}

extension Top {
    func getImage() -> ProfileImage {
        ProfileImage(id: self.id, full_url: self.full_url, thumb_url: self.thumb_url)
    }
}

extension Guest {
    func getVisitedPeriod() -> String {
        let date = self.visit_at?.toDate() ?? Date.now

        return date.getVisitPeriod()
    }
}

extension MyDuel {
    func getVisitedPeriod() -> String {
        let date = self.created_at?.toDate() ?? Date.now

        return date.getVisitPeriod()
    }
}

extension Like {
    func getTime() -> String {
        let createdDate = self.created_at
        let date = createdDate?.toDate() ?? Date.now
        let components = Calendar.current.dateComponents([.day], from: date, to: Date.now)
        let days = components.day ?? 0

        if days == 0 {
            return self.created_at?.getTime() ?? date.toString()
        } else {
            return self.created_at?.getWeekdayWithTime() ?? date.toString()
        }
    }
}

extension Match {
    func getTime() -> String {
        let createdDate = self.created_at
        let date = createdDate?.toDate() ?? Date.now
        let components = Calendar.current.dateComponents([.day], from: date, to: Date.now)
        let days = components.day ?? 0

        if days == 0 {
            return self.created_at?.getTime() ?? date.toString()
        } else {
            return self.created_at?.getWeekdayWithTime() ?? date.toString()
        }
    }
}

extension Chat {
    func getLastMessageTime() -> String {
        let createdDate = self.last_message?.created_at
        let date = createdDate?.toDate() ?? Date.now
        let components = Calendar.current.dateComponents([.day], from: date, to: Date.now)
        let days = components.day ?? 0

        if days > 6 {
            return createdDate?.toShortDateString() ?? date.toString()
        } else if days > 0 {
            return createdDate?.getWeekday() ?? date.toString()
        } else {
            return createdDate?.getTime() ?? date.toString()
        }
    }
}

extension Questionnaire {
    func isEmpty() -> Bool {
        self.purpose == nil &&
        self.expectations == nil &&
        self.height == nil &&
        self.weight == nil &&
        self.eye_color == nil &&
        self.hair_color == nil &&
        self.hair_length == nil &&
        self.marital_status == nil &&
        self.kids == nil &&
        self.education == nil &&
        self.occupation == nil &&
        self.nationality == nil &&
        self.about_me == nil &&
        self.search_age_min == nil &&
        self.search_age_max == nil &&
        self.search_country == nil &&
        self.search_city == nil &&
        (self.socials == nil || (self.socials?.isEmpty ?? true)) &&
        (self.hobby == nil || (self.hobby?.isEmpty ?? true)) &&
        (self.sport == nil || (self.sport?.isEmpty ?? true)) &&
        self.evening_time == nil
    }

    func isFull() -> Bool {
        self.purpose != nil &&
        self.expectations != nil &&
        self.height != nil &&
        self.weight != nil &&
        self.eye_color != nil &&
        self.hair_color != nil &&
        self.hair_length != nil &&
        self.marital_status != nil &&
        self.kids != nil &&
        self.education != nil &&
        self.occupation != nil &&
        self.nationality != nil &&
        self.about_me != nil &&
        self.search_age_min != nil &&
        self.search_age_max != nil &&
        self.search_country != nil &&
        self.search_city != nil &&
        self.socials != nil &&
        !(self.socials?.isEmpty ?? true) &&
        self.hobby != nil &&
        !(self.hobby?.isEmpty ?? true) &&
        self.sport != nil &&
        !(self.sport?.isEmpty ?? true) &&
        self.evening_time != nil
    }
}

extension GeocodingResponse {
    func getSaveLocationRequest() -> SetUserLocationRequest {
        SetUserLocationRequest(lat: self.lat ?? "",
                               lng: self.lon ?? "",
                               iso_code: self.address?.country_code ?? "",
                               country: self.address?.country ?? "",
                               state: self.address?.country_code ?? "",
                               state_name: self.address?.state_district,
                               city: self.address?.city ?? (self.address?.town ?? ""))
    }

    func getSearchFilter(range: Int) -> Filter {
        Filter(location:
                FilterLocation(range: range,
                               lat: self.lat ?? "",
                               lng: self.lon ?? "")
        )
    }
}

extension URLResponse {
    var http: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}

extension HTTPURLResponse {
    var isSuccessful: Bool {
        return 200 ... 299 ~= statusCode
    }
}
