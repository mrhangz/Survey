//
//  NetworkManager.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    fileprivate var token: String?
    fileprivate let username: String = "carlos@nimbl3.com"
    fileprivate let password: String = "antikera"
    fileprivate let baseURL: String = "https://nimbl3-survey-api.herokuapp.com"
    
    static let shared = NetworkManager()
    
    lazy var manager: SessionManager = {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 30
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 30
        return Alamofire.SessionManager.default
    }()
    
    func validateToken(completion: @escaping () -> Void) {
        if let tokenExpiringDate = UserDefaults.standard.object(forKey: "token_expires_at") as? Date {
            if tokenExpiringDate < Date() {
                if let token = UserDefaults.standard.string(forKey: "token") {
                    self.token = token
                    completion()
                }
            }
        }
        getToken { (error) in
            guard let _ = error else {
                completion()
                return
            }
        }
    }
    
    func getToken(completion: @escaping (Error?) -> Void) {
        let requestURL: String = "\(baseURL)/oauth/token"
        manager.request(requestURL, method: .post, parameters: ["grant_type": "password", "username": username, "password": password])
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                    let expiringTimeInterval = json["created_at"].doubleValue + json["expires_in"].doubleValue
                    let expiringDate = Date(timeIntervalSince1970: expiringTimeInterval)
                    UserDefaults.standard.set(expiringDate, forKey: "token_expires_at")
                    UserDefaults.standard.synchronize()
                    self.token = json["access_token"].stringValue
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func getSurveys(completion: @escaping ([Survey]?, Error?) -> Void) {
        validateToken {
            let perPage = 50
            let requestURL: String = "\(self.baseURL)/surveys.json?page=1&per_page=\(perPage)"
            self.manager.request(requestURL, headers: ["Authorization": "Bearer \(self.token ?? "")"])
                .validate()
                .responseJSON { (response) in
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
    }
    
    func cancelAllRequests() {
        manager.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
    }
}
