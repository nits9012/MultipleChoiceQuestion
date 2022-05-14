//
//  CheckableTableViewCell.swift
//  AssigmentTask1
//
//  Created by Nitin Bhatt on 5/14/22.
//

import Foundation
import UIKit

class CheckableTableViewCell:UITableViewCell{
    
    @IBOutlet weak var optionButton: UIButton!
    
    var onOptionSelection:(()->())?
    
    class var identifier:String{String(describing: self)}
    class var nib:UINib{UINib(nibName: identifier, bundle: nil)}
    
    override func awakeFromNib() {
    }
    
    @IBAction func optionButtonAction(_ sender: Any) {
        if let onSelection = onOptionSelection{
            onSelection()
        }
    }
}
