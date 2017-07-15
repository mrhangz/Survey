//
//  SurveyViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/15/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class SurveyViewModel: NSObject {
    
    var surveys: [Survey] = []
    var networkManager: NetworkManager = NetworkManager()
    var tokenManager: TokenManager = TokenManager()
    
    func getSurveys(completion: @escaping (Bool) -> Void) {
        networkManager.getSurveys { (surveys, error) in
            if surveys != nil {
                self.surveys = surveys!
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getCellImage(index: Int, completion: @escaping (Any?) -> Void) {
        if surveys[index].coverImageURL != nil {
            networkManager.getImage(imageURL: surveys[index].coverImageURL!) { response in
                completion(response)
            }
        }
    }
    
    func getToken(completion: @escaping () -> Void) {
        tokenManager.getToken {
            completion()
        }
    }
    
    func renewToken(completion: @escaping () -> Void) {
        tokenManager.clearToken()
        getToken(completion: completion)
    }
    
}
