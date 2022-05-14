//
//  MultipleChoiceQuestions+CoreDataProperties.swift
//  AssigmentTask1
//
//  Created by Nitin Bhatt on 5/14/22.
//
//

import Foundation
import CoreData


extension MultipleChoiceQuestions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MultipleChoiceQuestions> {
        return NSFetchRequest<MultipleChoiceQuestions>(entityName: "MultipleChoiceQuestions")
    }

    @NSManaged public var id: Int16
    @NSManaged public var questions: String?
    
    //options available for question
    @NSManaged public var options: NSObject?
    
    // Correct answer of question
    @NSManaged public var answer: String?
    
    // option seleted by user
    @NSManaged public var selected: String?
}

extension MultipleChoiceQuestions : Identifiable {

}
