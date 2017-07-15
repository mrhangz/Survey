//
//  SurveyViewController.swift
//  Survey
//
//  Created by Teerawat Vanasapdamrong on 7/13/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class TakeSurveyViewController: UITableViewController {
    
    var viewModel: TakeSurveyViewModel?
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        navigationItem.title = viewModel?.survey?.title
        self.tableView.tableHeaderView = coverImageView
        viewModel?.getCoverImage() { image in
            self.coverImageView.image = image as? UIImage
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel!.questionCount()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let questionView = QuestionView.instanceFromNib()
        questionView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: questionView.frame.size.height)
        let question = viewModel?.survey?.questions?[section]
        let string = question?.text ?? ""
        let trimmed = string.replacingOccurrences(of: "^\\n*", with: "", options: .regularExpression)
        questionView.textLabel.text = trimmed
        questionView.helpTextLabel.text = question?.helpText ?? ""
        viewModel?.getCellImage(index: section) { response in
            questionView.coverImageView.image = response as? UIImage
            questionView.coverImageView.alpha = CGFloat(question?.coverImageOpacity ?? 1.0)
        }
        return questionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.answerCount(questionIndex: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = viewModel?.survey?.questions?[indexPath.section]
        var cell: UITableViewCell
        if question?.displayType == "textarea" {
            cell = tableView.dequeueReusableCell(withIdentifier: "TextAreaCell", for: indexPath)
        } else if question?.displayType == "textfield" {
            cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath)
            cell.textLabel?.text = question?.answers?[indexPath.row].text
        }
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
