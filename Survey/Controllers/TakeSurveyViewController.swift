//
//  SurveyViewController.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/13/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class TakeSurveyViewController: UITableViewController {
    
    var viewModel: SurveyViewModel!
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        navigationItem.title = viewModel.surveyTitle()
        self.tableView.tableHeaderView = coverImageView
        self.coverImageView.sd_setImage(with: viewModel.surveyImageURL())
    }
    
    deinit {
        viewModel.cancelNetworkRequests()
    }
    
    // MARK: UITableView data source and delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.questionCount()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let questionView = QuestionView.instanceFromNib()
        questionView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: questionView.frame.size.height)
        let questionViewModel = viewModel.questionViewModel(forIndex: section)
        questionView.viewModel = questionViewModel
        questionView.displayQuestion()
        questionView.coverImageView.sd_setImage(with: questionViewModel.questionImageURL())
        
        return questionView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.answerCount(questionIndex: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let questionViewModel = viewModel.questionViewModel(forIndex: indexPath.section)
        cell = tableView.dequeueReusableCell(withIdentifier: questionViewModel.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = questionViewModel.answerViewModel(forIndex: indexPath.row).answerText()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        for selectedIndexPath in tableView.indexPathsForSelectedRows ?? [] {
            if selectedIndexPath.section == indexPath.section && selectedIndexPath.item != indexPath.item {
                tableView.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
        return indexPath
    }
    
}
