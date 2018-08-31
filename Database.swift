//
//  Database.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 30.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData



class Database  {
    var x: String = ""
    var context : NSManagedObjectContext?
    var  productTable: ProductTable?
    
    var productArray=[ProductTable]()
    
    func printPath()
    {
        
        
        print(FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask))
    }
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        productTable = ProductTable(context: context!)
    }
    func save()
    {
        do {
            try context?.save()
        }
        catch
        {
            print("Error saveing context \(error)")
        }
    }
    func loadData()
    {
        let request : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        do {        productArray = (try context?.fetch(request))!        }
        catch { print("Error fetching data from context \(error)")   }
    }
    func editData()
    {
        let row = 0
        let value = "AAA"

        productArray[row].producent = value
        save()
        
        //let key = "producent"
        // productArray[row].setValue(value, forKey: key)
    }
    func deleteOne()
    {
        let row = 0
        context?.delete(productArray[row])
        productArray.remove(at: row)

        save()
    }
    func fillTestData()
    {
        productTable?.id = 111
        productTable?.producent = "Producent"
        productTable?.productName = "Producent Name"
        productTable?.eanCode = "454556455"
        productTable?.weight = 4584
        productTable?.number1 = 1
        productTable?.number2 = 1
        productTable?.number3 = 1
    }
    func filterData()  {
        //let ageIs33Predicate = NSPredicate(format: "%K = %@", "age", "33")
        //let namesBeginningWithLetterPredicate = NSPredicate(format: "(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)")
        
        //(people as NSArray).filteredArrayUsingPredicate(namesBeginningWithLetterPredicate.predicateWithSubstitutionVariables(["letter": "A"]))
        // ["Alice Smith", "Quentin Alberts"]
        
        let searchField = "producent"
        let sortField = "producent"
        let searchText = "Knor"
        let reqest : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        //let predicate=NSPredicate(format: "producent CONTAINS[cd] %@", searchText)
        let predicate=NSPredicate(format: "%K CONTAINS[cd] %@", searchField, searchText)
        reqest.predicate=predicate
        let sortDeescryptor=NSSortDescriptor(key: sortField, ascending: true)
        reqest.sortDescriptors=[sortDeescryptor]
        do {
            productArray = (try context?.fetch(reqest))!
        } catch  {
            print("Error feaching data from context \(error)")
        }
        updateGUI()
    }
    func updateGUI()
    {
    }
}

