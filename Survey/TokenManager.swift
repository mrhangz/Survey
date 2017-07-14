//
//  TokenManager.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class TokenManager: NSObject {
    func getToken(completion: @escaping () -> Void) {
        guard let _ = UserDefaults.standard.value(forKey: "token") else {
            NetworkManager().getToken() { (token, error) in
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
