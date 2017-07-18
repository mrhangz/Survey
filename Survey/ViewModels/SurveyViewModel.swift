//
//  SurveyViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/15/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class SurveyViewModel: NSObject {
    
    private var survey: Survey
    
    init(survey: Survey) {
        self.survey = survey
    }
    
    func questionCount() -> Int {
        return survey.questions?.count ?? 0
    }
    
    func answerCount(questionIndex: Int) -> Int {
        return survey.questions?[questionIndex].answers?.count ?? 0
    }
    
    func surveyTitle() -> String? {
        return survey.title
    }
    
    func surveyDescription() -> String? {
        return survey.description
    }
    
    func surveyImageURL() -> URL? {
        guard let _ = survey.coverImageURL else {
            return nil
        }
        return URL(string: survey.coverImageURL! + "l")
    }
    
    func questionViewModel(forIndex index: Int) -> QuestionViewModel {
        let question = survey.questions![index]
        let viewModel = QuestionViewModel(question: question)
        return viewModel
    }
    
    func cancelNetworkRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
