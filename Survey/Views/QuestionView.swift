//
//  QuestionView.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    var viewModel: QuestionViewModel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var helpTextLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> QuestionView {
        return UINib(nibName: "QuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! QuestionView
    }
    
    func displayQuestion() {
        textLabel.text = viewModel.questionText()
        helpTextLabel.text = viewModel.questionHelpText()
    }
}
