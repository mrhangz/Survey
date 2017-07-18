//
//  SurveyCollectionViewController.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/12/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import CHIPageControl
import KVLoading

// MARK: View lifecycle

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CHIPageControlAji!
    
    var viewModel: SurveysViewModel = SurveysViewModel()
    
    override func viewDidLoad() {
        pageControl.transform = CGAffineTransform(rotationAngle: .pi / 2)
        refresh()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let index = self.collectionView!.contentOffset.y / self.collectionView!.frame.size.height
        coordinator.animate(alongsideTransition: { context in
            let newYOffset = self.collectionView.frame.size.height * index
            self.collectionView?.scrollRectToVisible(CGRect(x: 0, y: newYOffset, width: self.collectionView!.frame.size.width, height: self.collectionView!.frame.size.height), animated: false)
        })
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TakeSurvey" {
            let destinationVC = segue.destination as! TakeSurveyViewController
            let survey = sender as! Survey
            let viewModel = SurveyViewModel(survey: survey)
            destinationVC.viewModel = viewModel
        }
    }
}

extension SurveyViewController {
    @IBAction func refresh() {
        KVLoading.show()
        viewModel.getSurveys() { flag in
            if flag {
                self.collectionView.reloadData()
                self.pageControl.numberOfPages = self.viewModel.surveyCount()
                if self.viewModel.surveyCount() > 0 {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            } else {
                self.showAlert()
            }
            KVLoading.hide()
        }
    }
}

// MARK: Data Source & Delegate

extension SurveyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.y / scrollView.contentSize.height * CGFloat(viewModel.surveyCount())
        
        pageControl.progress = Double(progress)
    }
    
}

extension SurveyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.surveyCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.surveyCount() == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCell", for: indexPath) as! SurveyCollectionViewCell
            let cellViewModel = viewModel.cellViewModel(forIndex: indexPath.row)
            cell.takeSurveyButton.tag = indexPath.row
            cell.delegate = self
            cell.viewModel = cellViewModel
            cell.displaySurvey()
            
            return cell
        }
    }
    
}

// MARK: Delegation

extension SurveyViewController: SurveyCollectionViewCellDelegate {
    func takeSurvey(index: Int) {
        performSegue(withIdentifier: "TakeSurvey", sender: viewModel.allSurveys()[index])
    }
}

extension SurveyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
}

// MARK: Show Error Message

extension SurveyViewController {
    func showAlert() {
        let alertController = UIAlertController(title: "Something went wrong", message: "Try refreshing?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (result : UIAlertAction) -> Void in
            self.refresh()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
