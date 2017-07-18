//
//  SurveyTableViewCell.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import SDWebImage

protocol SurveyCollectionViewCellDelegate: class {
    func takeSurvey(index: Int)
}

class SurveyCollectionViewCell: UICollectionViewCell {
    
    var viewModel: SurveyViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takeSurveyButton: UIButton!
    
    weak var delegate: SurveyCollectionViewCellDelegate?
    
    @IBAction func takeSurvey(sender: UIButton) {
        delegate?.takeSurvey(index: sender.tag)
    }
    
    func displaySurvey() {
        titleLabel.text = viewModel.surveyTitle()
        descriptionLabel.text = viewModel.surveyDescription()
        imageView.sd_setImage(with: viewModel.surveyImageURL())
    }
}
