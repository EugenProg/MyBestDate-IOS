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
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self) ?? Date.now
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
}

extension Questionnaire {
    func isEmpty() -> Bool {
        self.purpose == nil &&
        self.height == nil &&
        self.weight == nil &&
        self.eye_color == nil &&
        self.hair_color == nil &&
        self.hair_length == nil &&
        self.marital_status == nil &&
        self.kids == nil &&
        self.education == nil &&
        self.occupation == nil &&
        self.about_me == nil &&
        self.search_age_min == nil &&
        self.search_age_max == nil &&
        (self.socials == nil || (self.socials?.isEmpty ?? true)) &&
        (self.hobby == nil || (self.hobby?.isEmpty ?? true)) &&
        (self.sport == nil || (self.sport?.isEmpty ?? true)) &&
        self.evening_time == nil
    }

    func isFull() -> Bool {
        self.purpose != nil &&
        self.height != nil &&
        self.weight != nil &&
        self.eye_color != nil &&
        self.hair_color != nil &&
        self.hair_length != nil &&
        self.marital_status != nil &&
        self.kids != nil &&
        self.education != nil &&
        self.occupation != nil &&
        self.about_me != nil &&
        self.search_age_min != nil &&
        self.search_age_max != nil &&
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
    /// Returns casted `HTTPURLResponse`
    var http: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}

extension HTTPURLResponse {
    /// Returns `true` if `statusCode` is in range 200...299.
    /// Otherwise `false`.
    var isSuccessful: Bool {
        return 200 ... 299 ~= statusCode
    }
}
