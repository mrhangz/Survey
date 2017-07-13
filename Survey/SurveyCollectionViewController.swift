//
//  SurveyCollectionViewController.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import CHIPageControl
import Alamofire
import AlamofireImage
import KVLoading

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CHIPageControlAji!
    
    var surveys: [Survey] = []
    
    override func viewDidLoad() {
        KVLoading.show()
        pageControl.transform = CGAffineTransform(rotationAngle: .pi / 2)
        pageControl.frame = CGRect(x: self.view.frame.size.width - pageControl.frame.size.width, y: 0, width: pageControl.frame.size.width, height: self.collectionView.frame.size.height)
        
        NetworkManager(token: "36dece969c2c0ee12ffea0f63ad15e7e237e76434ca0f7c2bcf2e56a821d2011").getSurveys { (surveys, error) in
            if surveys != nil {
                self.surveys = surveys!
                self.pageControl.numberOfPages = self.surveys.count
                self.collectionView.reloadData()
            } else {
                print("\(error!.localizedDescription)")
            }
            KVLoading.hide()
        }
    }
    
}

extension SurveyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.y / scrollView.contentSize.height * CGFloat(self.surveys.count)
        
        pageControl.progress = Double(progress)
    }
    
}

extension SurveyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCell", for: indexPath) as! SurveyCollectionViewCell
        let survey = surveys[indexPath.row]
        cell.titleLabel.text = survey.title
        cell.descriptionLabel.text = survey.description
        if survey.coverImageURL != nil {
            NetworkManager().getImage(imageURL: survey.coverImageURL!) { response in
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageView.image = response
            }
        }
        
        return cell
    }
    
}

extension SurveyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
