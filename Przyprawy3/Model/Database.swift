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
    var context: NSManagedObjectContext
    
    // variable for ProductTable
    //var product: ProductTable
    var productArray : [ProductTable] = []
    var featchResultControllerProduct: NSFetchedResultsController<ProductTable>
    let feachProductRequest: NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
    let sortProductDescriptor = NSSortDescriptor(key: "productName", ascending: true)
    
    // variable for ShopingProductTable
    var shoping : ShopingProductTable
    var shopingList = [ShopingProductTable]()
    var feachShopingRequest:NSFetchRequest<ProductTable> = ProductTable.fetchRequest()

    init(context: NSManagedObjectContext) {
        self.context = context
        
        // init Eniity buffors
        //product = ProductTable(context: context)
        shoping = ShopingProductTable(context: context)
        
        feachProductRequest.sortDescriptors=[sortProductDescriptor]
        featchResultControllerProduct=NSFetchedResultsController(fetchRequest: feachProductRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

    }
    
    
    func addNewData(prod : Product) {
        //let context = coreData.persistentContainer.viewContext
        let product=ProductTable(context: context)
        var productsTab: [ProductTable] = []
        
        //coreData.persistentContainer.
        
        product.pictureName=prod.pictureName
        product.eanCode=prod.eanCode
        product.producent=prod.producent
        product.productName=prod.productName
        
        //        product.pictureName="prod.pictureName"
        //        product.eanCode="eanCode"
        //        product.producent="producent"
        //        product.productName="productName"
        productsTab.append(product)
        
        coreData.saveContext()
    }

    func delTable()  {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: DbTableNames.produkty.rawValue)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        let context=coreData.persistentContainer.viewContext
        
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
        //print("Preed kasowaniem productArray.count=\(productArray.count)")
        //productArray.removeAll()
        //print("Po productArray.count=\(productArray.count)")
        
        
        
        //database.deleteAllData(entity: DbTableNames.produkty.rawValue)
        //database.productArray.removeAll()

    }
    
    func addOneRecord(newProduct : ProductTable) {
                    print("Przed addOneRecord=\(self.productArray.count)")
                    self.productArray.append(newProduct)
                    print("Po addOneRecord=\(self.productArray.count)")
                    self.save()        
    }
        func fill(product rec : inout ProductTable)
        {
    
            rec.producent="Knor"
            rec.productName="no product"
            rec.eanCode="88888"
            rec.id=222
            rec.pictureName="pic1"
            rec.number1=1
            rec.number2=2
            rec.number3=3
            rec.searchTag="tag1"
        }

    func fillTestData(product : ProductTable)
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
            let newProductArray = (try context.fetch(reqest))
            productArray=newProductArray
        } catch  {
            print("Error feaching data from context \(error)")
        }
        updateGUI()
    }
    func save()
    {   print("save przed \(productArray.count)")
        do {   try context.save()    }
        catch  {  print("Error saveing context \(error)")   }
        print("save po \(productArray.count)")
    }
    func updateGUI() {
    
    }

}

