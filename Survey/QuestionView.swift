//
//  QuestionView.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/14/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var helpTextLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
//    var question: Question? {
//        didSet{
//            self.textLabel.text = question?.text
//            self.helpTextLabel.text = question?.helpText
//            if question?.coverImageURL != nil {
//                NetworkManager().getImage(imageURL: question!.coverImageURL!) { (response) in
//                    self.coverImageView.image = response
//                    self.coverImageView.alpha = CGFloat(self.question?.coverImageOpacity ?? 1.0)
//                }
//            }
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> QuestionView {
        return UINib(nibName: "QuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! QuestionView
    }
}
