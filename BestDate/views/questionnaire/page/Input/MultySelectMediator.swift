//
//  MultySelectMediator.swift
//  BestDate
//
//  Created by Евгений on 04.07.2022.
//

import Foundation

class MultySelectMediator: ObservableObject {
    static var shared = MultySelectMediator()

    @Published var questionInfo: QuestionInfo = QuestionInfo(id: 0)
    @Published var ansfersList: [AnsferInfo] = []

    func getAnsferLine() -> String {
        var line = ""
        for ansferInfo in ansfersList {
            if ansferInfo.isSelect {
                line.append("\(ansferInfo.ansfer), ")
            }
        }

        if !line.isEmpty {
            line = String(line.prefix(line.count - 2))
        }

        return line
    }

    private func setAnsfers(ansfers: [String]) {
        ansfersList.removeAll()
        for index in ansfers.indices {
            let ansfer = NSLocalizedString(ansfers[index], comment: "Ansfer")
            ansfersList.append(
                AnsferInfo(id: index,
                           ansfer: ansfer,
                           isSelect: questionInfo.selectedAnsfer.contains(ansfer))
            )
        }
    }

    func setQuestionInfo(questionInfo: QuestionInfo) {
        self.questionInfo = questionInfo
        setAnsfers(ansfers: questionInfo.ansfers)
    }

    func toggleItemSelect(id: Int) {
        ansfersList[id].isSelect.toggle()
    }
}

struct AnsferInfo {
    var id: Int = 0
    var ansfer: String = ""
    var isSelect: Bool = false
}
