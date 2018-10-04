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
    
    var product: ProductTable
    var productArray = [ProductTable]()
    var featchResultControllerProduct: NSFetchedResultsController<ProductTable>
    let feachProductRequest: NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
    let sortProductDescriptor = NSSortDescriptor(key: "productName", ascending: true)
    
    var shoping : ShopingTable
    var shopingList = [ShopingTable]()
    var feachShopingRequest:NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
    
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        product = ProductTable(context: context!)
        shoping = ShopingTable(context: context!)
        feachProductRequest.sortDescriptors=[sortProductDescriptor]
        featchResultControllerProduct=NSFetchedResultsController(fetchRequest: feachProductRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
    }

    func save()
    {
        do {   try context?.save()    }
        catch  {  print("Error saveing context \(error)")   }
    }
    func loadData()
    {
        let request : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        do {    let newProducyArray     = try context?.fetch(request)
            self.productArray = newProducyArray!
        }
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
    func deleteLast()
    {
        let row = productArray.count-1
       
        context?.delete(productArray[row])
        productArray.remove(at: row)
        save()
    }
    func deleteAllData(entity: String)
    {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context?.execute(DelAllReqVar) }
        catch { print(error) }
         print("Preed kasowaniem productArray.count=\(productArray.count)")
        productArray.removeAll()
        print("Po productArray.count=\(productArray.count)")
    }
    func addProduct(productElem : Product, id : Int, saving : Bool)
    {
        let newProduct = ProductTable(context: context!)
        
        newProduct.id = Int32(id)
        newProduct.producent   = productElem.producent
        newProduct.pictureName = productElem.pictureName
        newProduct.productName = productElem.productName
        newProduct.eanCode     = productElem.eanCode
        newProduct.weight      = Int16(productElem.weight)
        newProduct.number1     = Int16(productElem.number1)
        newProduct.number2     = Int16(productElem.number1)
        newProduct.number3     = Int16(productElem.number1)
        newProduct.searchTag   = "no tags"

        print("Rozmiar productArray przed \(productArray.count)")
        self.productArray.append(newProduct)
        print("Rozmiar productArray po \(productArray.count)")
        
        if productArray[productArray.count-1].pictureName == nil
        {
            print("---------")
            print("nul at \(productArray.count-1)")
            print("---------")

        }
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
        product.pictureName="Pict1"
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
    func toString(product: ProductTable, nr: Int)
    {
        // = ProductTable()
        print("\(nr)) \(String(describing: product.producent)) :  \(String(describing: product.productName)) :  \(product.weight)  : \(String(describing: product.eanCode)) : \(product.number1) : \(product.number2) : \(product.number3) : \(product.pictureName)")
    }
    func printPath()
    {
        print(FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask))
    }

}

