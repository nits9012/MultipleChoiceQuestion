//
//  MultipleChoiceQuestionsViewController.swift
//  AssigmentTask1
//
//  Created by Nitin Bhatt on 5/14/22.
//

import UIKit


class MultipleChoiceQuestionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var multipleChoiceQuestion = [MultipleChoiceQuestions]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        addMultipleChoiceQuestionValuesOnLocal()
    }
    
    func addMultipleChoiceQuestionValuesOnLocal(){
        DispatchQueue.main.async {
            SetHarcodeValuesForMultipleChoiceQuestion().setValues()
            self.getData()
        }

    }
    
    func getData(){
        multipleChoiceQuestion = MultipleChoiceQuestions().fetchMultipleChoiceQuestions()!
        tableView.reloadData()
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CheckableOptionView.nib, forCellReuseIdentifier: CheckableOptionView.identifier)
    }
}

extension MultipleChoiceQuestionsViewController:UITableViewDelegate,UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let options = self.multipleChoiceQuestion[indexPath.row].options as? [String]{
            
            if options.count <= 2{
               return CGFloat((options.count * 100))
            }else{
               return CGFloat((options.count * 80))
            }
        }

        // default
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multipleChoiceQuestion.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckableOptionView.identifier, for: indexPath) as? CheckableOptionView else{
                   fatalError("xib does not exists")
        }
        
        let multipleChoiceQuestionValue = multipleChoiceQuestion[indexPath.row]
        cell.questionLabel.text = multipleChoiceQuestionValue.questions
        
        
        if let options = multipleChoiceQuestionValue.options as? [String]{
            cell.options = options
            cell.optionsTableView.reloadData()
        }
        
        cell.selectedOption = multipleChoiceQuestionValue.selected ?? ""
        cell.id = Int(multipleChoiceQuestionValue.id)
        cell.questionAnswer = (multipleChoiceQuestionValue.answer) ?? ""

        
        cell.selectedAnswer = {
            self.getData()
        }
        
        if multipleChoiceQuestionValue.selected?.isEmpty == false{
                cell.correctAnswer.isHidden = false
            cell.correctAnswer.text = "Correct Answer is " + multipleChoiceQuestionValue.answer!
        }else{
            cell.correctAnswer.isHidden = true
        }
        
                
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


