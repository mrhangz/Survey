//
//  NetworkManager.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class NetworkManager: NSObject {
    private let baseURL: String = "https://nimbl3-survey-api.herokuapp.com"
    
    lazy var manager: SessionManager = {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 30
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 30
        return Alamofire.SessionManager.default
    }()
    
    override init() {
        
    }
    
    func login(username: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        let requestURL: String = "\(baseURL)/oauth/token"
        Alamofire.request(requestURL, method: .post, parameters: ["grant_type": "password", "username": username, "password": password]).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                completion(json["access_token"].stringValue, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getSurveys(completion: @escaping ([Survey]?, Error?) -> Void) {
        let perPage = 50
        let requestURL: String = "\(baseURL)/surveys.json?page=1&per_page=\(perPage)"
        let token = UserDefaults.standard.value(forKey: "token") as! String
        Alamofire.request(requestURL, headers: ["Authorization": "Bearer \(token)"]).responseJSON { (response) in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                var surveys: [Survey] = []
                for surveyDict in json.arrayValue {
                    let survey = Survey(json: surveyDict)
                    surveys.append(survey)
                }
                completion(surveys, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(imageURL + "l").responseImage { response in
            if let image = response.result.value {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
