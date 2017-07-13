//
//  SurveyViewController.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/13/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class TakeSurveyViewController: UIViewController {
    
    var survey: Survey?
    
    override func viewDidLoad() {
        navigationItem.title = survey?.title
    }
    
}
