//
//  AnswerViewModel.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/18/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class AnswerViewModel: NSObject {
    
    var answer: Answer
    
    init(answer: Answer) {
        self.answer = answer
    }
    
    func answerText() -> String {
        return answer.text ?? ""
    }
    
}
