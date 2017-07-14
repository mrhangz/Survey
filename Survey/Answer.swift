//
//  Answer.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

struct Answer {
    var id: String
    var text: String?
    
    init(id: String, text: String?) {
        self.id = id
        self.text = text
    }
}
