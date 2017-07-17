//
//  TokenManager.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class TokenManager: NSObject {
    
    private var username: String = "carlos@nimbl3.com"
    private var password: String = "antikera"
    var networkManager: NetworkManager = NetworkManager()
    
    func getToken(completion: @escaping () -> Void) {
        guard let _ = UserDefaults.standard.value(forKey: "token") else {
            networkManager.login(username: username, password: password) { (token, error) in
                if token != nil {
                    UserDefaults.standard.setValue(token, forKey: "token")
                    UserDefaults.standard.synchronize()
                    completion()
                }
            }
            return
        }
        completion()
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.synchronize()
    }
}
