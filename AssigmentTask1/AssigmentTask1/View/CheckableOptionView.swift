//
//  CheckableOptionView.swift
//  AssigmentTask1
//
//  Created by Nitin Bhatt on 5/14/22.
//

import Foundation
import UIKit

class CheckableOptionView:UITableViewCell{
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    class var identifier:String{String(describing: self)}
    class var nib:UINib{UINib(nibName: identifier, bundle: nil)}
    
    var selectedAnswer:(()->())?
    
    // Values passed to CheckableTableViewCell
    var options = [String]()
    var id = Int()
    var selectedOption = String()
    var questionAnswer = String()
    //
    
    override func awakeFromNib() {
        self.initView()
        self.initTableView()
    }
    
    func initView(){
        separatorInset = .zero
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
    }
    
    func initTableView(){
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.tableFooterView = UIView()
        optionsTableView.separatorStyle = .none
        optionsTableView.register(CheckableTableViewCell.nib, forCellReuseIdentifier: CheckableTableViewCell.identifier)
    }
}

extension CheckableOptionView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckableTableViewCell.identifier, for: indexPath) as? CheckableTableViewCell else{
                   fatalError("xib does not exists")
        }
        cell.backgroundColor = UIColor.clear

        
        (selectedOption == options[indexPath.row]) ?  (cell.optionButton.setImage(UIImage(named: "on"), for: .normal)) :             (cell.optionButton.setImage(UIImage(named: "off"), for: .normal))


        if selectedOption == options[indexPath.row]{
            (questionAnswer == selectedOption) ? (cell.backgroundColor = UIColor.green) : (cell.backgroundColor = UIColor.red)
        }
 
        cell.optionButton.setTitle(options[indexPath.row], for: .normal)
        
        cell.onOptionSelection = {
            MultipleChoiceQuestions().upldateSelectedQuestionValue(seletedOption: self.options[indexPath.row], id: self.id)
            if let selection = self.selectedAnswer{
                selection()
            }
        }
        
        return cell
    }
}
