//
//  TakeSurveyViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/15/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class TakeSurveyViewModel: NSObject {
    
    var survey: Survey?
    var networkManager: NetworkManager = NetworkManager()
    
    init(survey: Survey) {
        self.survey = survey
    }
    
    func getSurveys(completion: @escaping (Bool) -> Void) {
        
    }
    
    func getCoverImage(completion: @escaping (Any?) -> Void) {
        if survey?.coverImageURL != nil {
            networkManager.getImage(imageURL: survey!.coverImageURL!) { response in
                completion(response)
            }
        }
    }
    
    func questionCount() -> Int {
        return survey?.questions?.count ?? 0
    }
    
    func getCellImage(index: Int, completion: @escaping (Any?) -> Void) {
        if survey?.questions?[index].coverImageURL != nil {
            NetworkManager().getImage(imageURL: survey!.questions![index].coverImageURL!) { (response) in
                completion(response)
            }
        }
    }
    
    func answerCount(questionIndex: Int) -> Int {
        return survey?.questions?[questionIndex].answers?.count ?? 0
    }
    
}
