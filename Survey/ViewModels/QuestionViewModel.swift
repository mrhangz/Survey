//
//  QuestionViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/18/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class QuestionViewModel: NSObject {
    
    var question: Question
    
    init(question: Question) {
        self.question = question
    }
    
    func questionText() -> String {
        guard let string = question.text else {
            return ""
        }
        return string.replacingOccurrences(of: "^\\n*", with: "", options: .regularExpression)
    }
    
    func questionHelpText() -> String {
        return question.helpText ?? ""
    }
    
    func questionImageURL() -> URL? {
        guard let _ = question.coverImageURL else {
            return nil
        }
        return URL(string: question.coverImageURL! + "l")
    }
    
    func cellIdentifier() -> String {
        if question.displayType == "textarea" {
            return "TextAreaCell"
        } else if question.displayType == "textfield" {
            return "TextFieldCell"
        } else {
            return "ChoiceCell"
        }
    }
    
    func answerViewModel(forIndex index: Int) -> AnswerViewModel {
        let answer = question.answers![index]
        let viewModel = AnswerViewModel(answer: answer)
        return viewModel
    }
    
}
