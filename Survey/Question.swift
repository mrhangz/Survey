//
//  Question.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question {
    var id: String
    var text: String?
    var helpText: String?
    var coverImageURL: String?
    var coverImageOpacity: Float?
    var displayType: String?
    var answers: [Answer]?
    
    init(id: String, text: String?) {
        self.id = id
        self.text = text
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.text = json["text"].string
        self.helpText = json["help_text"].string
        self.coverImageURL = json["cover_image_url"].string
        self.coverImageOpacity = json["cover_image_opacity"].float
        self.displayType = json["display_type"].string
        var answers: [Answer] = []
        for answerDict in json["answers"].arrayValue {
            let answer = Answer(id: answerDict["id"].stringValue, text: answerDict["text"].string)
            answers.append(answer)
        }
        self.answers = answers
    }
}
