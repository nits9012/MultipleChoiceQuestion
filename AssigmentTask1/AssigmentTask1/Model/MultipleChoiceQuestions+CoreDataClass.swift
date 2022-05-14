//
//  MultipleChoiceQuestions+CoreDataClass.swift
//  AssigmentTask1
//
//  Created by Nitin Bhatt on 5/14/22.
//
//

import Foundation
import CoreData

class SetHarcodeValuesForMultipleChoiceQuestion{
    
    // to delete all the previously store values
    func deleteValues(completion: ()->()){
        MultipleChoiceQuestions().deleteAllValues()
        completion()
    }
    
    func setValues(){
        deleteValues {

            MultipleChoiceQuestions().insertMultipleChoiceQuestions(id: 1, question: "The metal whose salts are sensitive to light is ?", options: ["Silver","Copper","Aluminium"], answer: "Silver", selected: "")
            
            MultipleChoiceQuestions().insertMultipleChoiceQuestions(id: 2, question: "Which is considered as the biggest port of India ?", options: ["Kolkata","Mumbai"], answer: "Mumbai", selected: "")

            MultipleChoiceQuestions().insertMultipleChoiceQuestions(id: 3, question: "The gas used for making vegetables is ?", options: ["Oxygen","Carbon dioxide","Hydrogen"], answer: "Hydrogen", selected: "")
            
            MultipleChoiceQuestions().insertMultipleChoiceQuestions(id: 4, question: "Country that was called as Land of Rising Sun ?", options: ["Russia","Japan","Korea","Holland"], answer: "Japan", selected: "")
        }
    }
}

@objc(MultipleChoiceQuestions)
public class MultipleChoiceQuestions: NSManagedObject {
    
    func insertMultipleChoiceQuestions(id:Int,question:String,options:[String],answer:String,selected:String){
        
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MultipleChoiceQuestions", in: managedObjectContext)
        let mcq = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        mcq.setValue(id, forKey: "id")
        mcq.setValue(question, forKey: "questions")
        mcq.setValue(options, forKey: "options")
        mcq.setValue(answer, forKey: "answer")
        mcq.setValue(selected, forKey: "selected")
        
        do{
            try managedObjectContext.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func fetchMultipleChoiceQuestions()->[MultipleChoiceQuestions]?{
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MultipleChoiceQuestions")
        fetch.sortDescriptors = [NSSortDescriptor(key: "questions", ascending: true)]
        
        do{
            let values = try managedObjectContext.fetch(fetch)
            return values as? [MultipleChoiceQuestions]
        }catch let error as NSError{
            print(error)
            return nil
        }
    }
    
    func deleteAllValues(){
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MultipleChoiceQuestions")
        
        do{
           let values = try  managedObjectContext.fetch(fetch)
            for value in values{
                managedObjectContext.delete(value)
                try managedObjectContext.save()
            }
        }catch let error as NSError{
            print(error)
        }
    }
//
    func upldateSelectedQuestionValue(seletedOption:String,id:Int){
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MultipleChoiceQuestions")
        print(id)
        fetch.predicate = NSPredicate(format: "id == %@", id as NSNumber)

        do{
            let values = try managedObjectContext.fetch(fetch)
            if values.count > 0{
                values[0].setValue(seletedOption, forKey: "selected")
            }

        }catch let error as NSError{
            print(error)
        }

    }
}
