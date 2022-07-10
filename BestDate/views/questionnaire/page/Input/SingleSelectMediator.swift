//
//  SingleSelectMediator.swift
//  BestDate
//
//  Created by Евгений on 28.06.2022.
//

import Foundation

class SingleSelectMediator: ObservableObject {
    static var shared = SingleSelectMediator()

    @Published var questionInfo: QuestionInfo = QuestionInfo(id: 0)
    
}
