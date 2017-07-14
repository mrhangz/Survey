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

// MARK: View lifecycle

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CHIPageControlAji!
    
    var surveys: [Survey] = []
    
    override func viewDidLoad() {
        pageControl.transform = CGAffineTransform(rotationAngle: .pi / 2)
        pageControl.frame = CGRect(x: self.view.frame.size.width - pageControl.frame.size.width, y: 0, width: pageControl.frame.size.width, height: self.collectionView.frame.size.height)
        TokenManager().getToken { (token) in
            self.refresh()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TakeSurvey" {
            let destinationVC = segue.destination as! TakeSurveyViewController
            let survey = sender as! Survey
            destinationVC.survey = survey
        }
    }
}

extension SurveyViewController {
    @IBAction func refresh() {
        KVLoading.show()
        NetworkManager().getSurveys { (surveys, error) in
            if surveys != nil {
                self.surveys = surveys!
                self.pageControl.numberOfPages = self.surveys.count
                self.collectionView.reloadData()
                if self.surveys.count > 0 {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            } else {
                self.showAlert()
            }
            KVLoading.hide()
        }
    }
}

// MARK: UIScrollView, UICollectionView Data Source & Delegate

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
        if self.surveys.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCell", for: indexPath) as! SurveyCollectionViewCell
            let survey = surveys[indexPath.row]
            cell.takeSurveyButton.tag = indexPath.row
            cell.delegate = self
            cell.titleLabel.text = survey.title
            cell.descriptionLabel.text = survey.description
            if survey.coverImageURL != nil {
                NetworkManager().getImage(imageURL: survey.coverImageURL!) { response in
                    if response != nil {
                        cell.imageView.contentMode = .scaleAspectFill
                        cell.imageView.image = response
                    } else {
                        cell.imageView.contentMode = .center
                        cell.imageView.image = UIImage(named: "noimage")
                    }
                }
            }
            
            return cell
        }
    }
    
}

// MARK: Delegation

extension SurveyViewController: SurveyCollectionViewCellDelegate {
    func takeSurvey(index: Int) {
        performSegue(withIdentifier: "TakeSurvey", sender: surveys[index])
    }
}

extension SurveyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

// MARK: Show Error Message

extension SurveyViewController {
    func showAlert() {
        let alertController = UIAlertController(title: "Something went wrong", message: "Maybe a token is expired. Try getting a new one?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (result : UIAlertAction) -> Void in
            TokenManager().clearToken()
            TokenManager().getToken() {
                self.refresh()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
