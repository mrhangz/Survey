//
//  Survey.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

struct Survey {
    var id: String
    var title: String?
    var description: String?
    var coverImageURL: String?
    
    init(id: String, title: String?, description: String?, coverImageURL: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.coverImageURL = coverImageURL
    }
}
