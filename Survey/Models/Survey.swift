//
//  Survey.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Survey {
    var id: String
    var title: String?
    var description: String?
    var coverImageURL: String?
    var questions: [Question]?
    
    init(id: String, title: String?, description: String?, coverImageURL: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.coverImageURL = coverImageURL
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["title"].string
        self.description = json["description"].string
        self.coverImageURL = json["cover_image_url"].string
        var questions: [Question] = []
        for questionDict in json["questions"].arrayValue {
            let question = Question(json: questionDict)
            questions.append(question)
        }
        self.questions = questions
    }
}
