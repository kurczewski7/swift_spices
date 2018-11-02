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
    func loadData()
    {
        let request : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        do {    let newProducyArray     = try context.fetch(request)
            if newProducyArray[0].productName != nil  {      self.productArray = newProducyArray }
            else {
                print("Error loading empty data ")
            }
        }
        catch { print("Error fetching data from context \(error)")   }
    }
    
    
    
    func addNewData(prod : Product) {
    
        let product=ProductTable(context: context)
        //var productsTab: [ProductTable] = []
        
        //coreData.persistentContainer.
        
        product.pictureName=prod.pictureName
        product.eanCode=prod.eanCode
        product.producent=prod.producent
        product.productName=prod.productName
        
        database.productArray.append(product)
         //productsTab.append(product)
        
        coreData.saveContext()
    }
    func deleteOne(withProductRec row : Int = -1)
    {
        let r = (row == -1 ? productArray.count-1 : row)
        
        context.delete(productArray[r])
        productArray.remove(at: r)        
        save()
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
    func save() {
        do {   try context.save()    }
        catch  {  print("Error saveing context \(error)")   }
    }
    func addAllRecords(products: [Product])
    {
        print("===== addAllProducts  ====")
        print("rozmiar danych do bazy: \(products.count)")
        
        for i in 0..<products.count
            
        {
            addProduct(productElem: products[i], id: i, saving: false)
        }
        //self.addProduct(productElem: products[0], id: 1, saving: false)
        //self.addProduct(productElem: products[0], id: 2, saving: false)
        //self.addProduct(productElem: products[0], id: 3, saving: false)
        
        self.save()
    }
    func addProduct(productElem : Product, id : Int, saving : Bool)
    {
        let newProduct = ProductTable(context: context)
        
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
     }
    func wczytywanieElementowBazy(_ nrElem : Int)
    {
        //let product : Product  // =Product()
        
        let product = giveElement(with: nrElem)
        
        addProduct(productElem: product, id: nrElem, saving: false)
        product.toString()
        
        //database.addAllProducts(products: T##[Product]
        database.save()
    }
    func giveElement(with nr: Int) -> Product
    {
        var product : Product = Product()
        var weight: Int
        var eanCode: String
        
        let pictureName:String = picturesArray[nr]
        let elementy = pictureName.split(separator: "_", maxSplits: 11, omittingEmptySubsequences: false)
        print("---- \(pictureName)  ----")
        for i in 0..<elementy.count
        {
            print("\(i) = \(elementy[i])")
        }
        if elementy.count > 0
        {
            let producent : String = String(elementy[0])
            let productName = NSMutableString()
            let zakres=elementy.count-5
            for i in 1..<zakres {
                productName.append("\(String(elementy[i])) ")
            }
            // Mark: substring of string
            let str=String(elementy[elementy.count-5])
            
            let size=str.distance(from: str.startIndex, to: str.endIndex)-1
            let index = str.index(str.startIndex, offsetBy:  size)
            if let  w : Int = Int(str.prefix(upTo: index)) {
                weight = w
            }
            else {
                weight = 0
            }
            
            let number3 = Int(elementy[elementy.count-1])
            let number2 = Int(elementy[elementy.count-2])
            let number1 = Int(elementy[elementy.count-3])
            eanCode = String(elementy[elementy.count-4])
            if Int(eanCode) == nil {
                eanCode = "00000000"
            }
            
            product = Product(producent: producent, productName: productName as String, weight: weight, eanCode: eanCode, number1: number1 ?? 0, number2: number2 ?? 0, number3: number3 ?? 0 , pictureName: pictureName)
        }
        return product
    }

    func updateGUI() {
    
    }
    func toString(product: ProductTable, nr: Int)
    {
        // = ProductTable()
        print("\(nr)) \(String(describing: product.producent)) :  \(String(describing: product.productName)) :  \(product.weight)  : \(String(describing: product.eanCode)) : \(product.number1) : \(product.number2) : \(product.number3) : \(String(describing: product.pictureName))")
    }
    func printPath()
    {
        print(FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask))
    }


}

