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

    func getAnsferLine(_ translate: Bool = false) -> String {
        var line = ""
        for ansferInfo in ansfersList {
            if ansferInfo.isSelect {
                let name = translate ? ansferInfo.ansfer.localized() : ansferInfo.ansfer
                line.append("\(name), ")
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
            let ansfer = ansfers[index]
            let isSelect = questionInfo.selectedAnsfer.contains(ansfer) ||
                            questionInfo.selectedAnsfer.contains(ansfer.localized())
            ansfersList.append(
                AnsferInfo(id: index,
                           ansfer: ansfer,
                           isSelect: isSelect)
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
