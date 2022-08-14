//
//  KeyboardExtension.swift
//  BestDate
//
//  Created by Евгений on 12.08.2022.
//

import Foundation
import SwiftUI
import Combine

extension View {
  func keyboardSensible(_ offsetValue: Binding<CGFloat>) -> some View {

    return self
        .padding(.bottom, offsetValue.wrappedValue - 10)
        .onAppear {
            withAnimation(.spring()) {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in

                    let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first

                    let bottom = keyWindow?.safeAreaInsets.bottom ?? 0

                    let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height

                    offsetValue.wrappedValue = height - bottom
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    offsetValue.wrappedValue = 0
                }
            }

    }
  }
}
