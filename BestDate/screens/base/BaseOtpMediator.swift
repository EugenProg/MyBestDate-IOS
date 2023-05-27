//
//  BaseOtpMediator.swift
//  BestDate
//
//  Created by Евгений on 21.11.2022.
//

import Foundation

class BaseOtpMediator: ObservableObject {
    static var shared = BaseOtpMediator()

    @Published var time: Int = 0
    var expirition: Int = 59

    func startTimer() {
        self.expirition = 59
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.expirition -= 1
            if self.expirition <= 0 {
                timer.invalidate()
            }

            DispatchQueue.main.async {
                self.time = self.expirition
            }
        }
    }


    func stopTimer() {
        self.expirition = -1
    }
}
