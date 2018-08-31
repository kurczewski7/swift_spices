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

    var context : NSManagedObjectContext?
    var product: ProductTable = ProductTable()
    // var  productTable: ProductTable?
    var productArray=[ProductTable]()
    
    func printPath()
    {
         print(FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask))
    }
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        product = ProductTable(context: context!)
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
        product.id = 111
        product.producent = "Producent"
        product.productName = "Producent Name"
        product.eanCode = "454556455"
        product.weight = 4584
        product.number1 = 1
        product.number2 = 1
        product.number3 = 1
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
    func addProduct(productElem : Product, id : Int, saving : Bool)
    {
        product.id = Int32(id)
        product.producent   = productElem.producent
        product.pictureName = productElem.pictureName
        product.productName = productElem.productName
        product.eanCode     = productElem.eanCode
        product.weight      = Int16(productElem.weight)
        product.number1     = Int16(productElem.number1)
        product.number2     = Int16(productElem.number1)
        product.number3     = Int16(productElem.number1)
        
        self.productArray.append(product)
        if saving {
          self.save()
        }
    }
    func addAllProducts(products: [Product])
    {
        print("=========")
        print("rozmiar bazy: \(products.count)")
        for i in 0..<products.count
        {
            self.addProduct(productElem: products[0], id: i, saving: false)
        }
        self.save()
    }
    func updateGUI()
    {
    }
    func toString(product: ProductTable, nr: Int)
    {
        // = ProductTable()
        print("\(nr)) \(String(describing: product.producent)) :  \(String(describing: product.productName)) :  \(product.weight)  : \(String(describing: product.eanCode)) : \(product.number1) : \(product.number2) : \(product.number3)")
    }

}

