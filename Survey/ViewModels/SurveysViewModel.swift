//
//  SurveysViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/15/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class SurveysViewModel: NSObject {
    
    private var surveys: [Survey] = []
    
    func getSurveys(completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.getSurveys { (surveys, error) in
            if surveys != nil {
                self.surveys = surveys!
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func allSurveys() -> [Survey] {
        return surveys
    }
    
    func surveyCount() -> Int {
        return surveys.count
    }
    
    func cellViewModel(forIndex index: Int) -> SurveyViewModel {
        let viewModel = SurveyViewModel(survey: surveys[index])
        return viewModel
    }
    
    func cancelNetworkRequests() {
        NetworkManager.shared.cancelAllRequests()
    }
    
}
