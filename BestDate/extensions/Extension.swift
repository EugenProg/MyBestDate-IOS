//
//  Extension.swift
//  BestDate
//
//  Created by Евгений on 06.06.2022.
//

import Foundation
import SwiftUI
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
        NSLocalizedString(DateUtils().getZodiacSignByDate(date: self), comment: "Zodiac")
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
        //print(">>> Now: \(Date.now)\n>>> date: \(date)\n>>> days: \(days)\n>>> hours: \(hours)\n>>> min: \(minutes)")

        if days > 6 {
            return NSLocalizedString("was_recently", comment: "Was recently")
        } else if days > 0 {
            return String.localizedStringWithFormat(NSLocalizedString("was_n_days_ago", comment: "Days"), days)
        } else if hours > 0 {
            return String.localizedStringWithFormat(NSLocalizedString("was_n_hours_ago", comment: "Hours"), hours)
        } else if minutes > 0 {
            return String.localizedStringWithFormat(NSLocalizedString("was_n_min_ago", comment: "Minute"), minutes)
        } else {
            return ""
        }
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
        return dateFormatter.date(from: self) ?? Date.now
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
}

extension Array where Element == String {
    func equals(array: [String]?) -> Bool {
        if self.count != array?.count { return false }
        for item in self {
            if !(array?.contains(item) ?? false) { return false }
        }

        return true
    }
}

extension Array where Element == ProfileImage {
    mutating func clearAndAddAll(list: [ProfileImage]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == ShortUserInfo {
    mutating func clearAndAddAll(list: [ShortUserInfo]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == Top {
    mutating func clearAndAddAll(list: [Top]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == MyDuel {
    mutating func clearAndAddAll(list: [MyDuel]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension UserInfo {
    func getMainPhoto() -> ProfileImage? {
        for image in self.photos ?? [] {
            if image.main ?? false {
                return image
            }
        }
        return self.photos?.first
    }

    func getAge() -> Int {
        Calendar.current.dateComponents([.year], from: self.birthday?.toDate() ?? Date.now, to: Date.now).year ?? 0
    }

    func getDistance() -> String {
        String.localizedStringWithFormat(
            NSLocalizedString("disatnce_unit", comment: "Mask"),
            NSLocalizedString(String(format: "%.0f", self.distance ?? 0.0), comment: "Distance")
        )
    }

    func getLocation() -> String {
        let country = self.location?.country ?? ""
        let city = self.location?.city ?? ""

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

extension ShortUserInfo {
    func getAge() -> Int {
        Calendar.current.dateComponents([.year], from: self.birthday?.toDate() ?? Date.now, to: Date.now).year ?? 0
    }

    func getDistance() -> String {
        String.localizedStringWithFormat(
            NSLocalizedString("disatnce_unit", comment: "Mask"),
            NSLocalizedString(String(format: "%.0f", self.distance ?? 0.0), comment: "Distance")
        )
    }

    func toUser() -> UserInfo {
        UserInfo(
            id: self.id,
            name: self.name,
            gender: self.gender,
            birthday: self.birthday,
            is_online: self.is_online
        )
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
