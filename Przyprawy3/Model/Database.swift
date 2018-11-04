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
    func loadData()  {
        let request : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        do {    let newProducyArray     = try context.fetch(request)
            if newProducyArray[0].productName != nil  {      self.productArray = newProducyArray }
            else {
                print("Error loading empty data ")
            }
        }
        catch { print("Error fetching data from context \(error)")   }
    }

    func deleteOne(withProductRec row : Int = -1) {
        let r = (row == -1 ? productArray.count-1 : row)
        context.delete(productArray[r])
        productArray.remove(at: r)        
        save()
    }
    func delTable()  {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: DbTableNames.products.rawValue)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        let context=coreData.persistentContainer.viewContext
        
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
        //productArray.removeAll()
        //database.deleteAllData(entity: DbTableNames.produkty.rawValue)
        //database.productArray.removeAll()
    }
    
      func addOneRecord(newProduct : ProductTable) {
        self.productArray.append(newProduct)
        self.save()
    }
    func addProduct(withProductId id : Int, saving : Bool = true)    {
        let productElem = giveElement(withProduct: id)
        productElem.id=Int32(id)
        self.productArray.append(productElem)
        if productArray[productArray.count-1].pictureName == nil
        {
            print("---------")
            print("nul at \(productArray.count-1)")
            print("---------")
        }
        if saving {
            save()
        }
    }
    func giveElement(withProduct nr: Int) -> ProductTable
    {
        let product : ProductTable = ProductTable(context: context)
        let weight: Int
        var eanCode: String
        var w : String = ""
        
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
            let str2=String(elementy[elementy.count-6])
            let str3=String(elementy[elementy.count-7])
            
            if database.substrng(right: str, len: 1).uppercased() == "G"    {
                w=database.substrng(left: str, len: str.count-1)
                if str.count==1 {
                    w =  String(elementy[elementy.count-6])
                }
                else
                {
                   w = database.substrng(left: str, len: str.count-1)
                }
            }
            else if database.substrng(right: str2, len: 1).uppercased() == "G"  {
                w=database.substrng(left: str2, len: str2.count-1)
            } else if database.substrng(right: str3, len: 1).uppercased() == "G" {
            }
            else {
                w="0"
            }
            
            if let  value : Int = Int(w) {
                weight = value
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
            product.producent  = producent
            product.productName=String(productName)
            product.eanCode    =  eanCode
            product.pictureName=pictureName
            product.number1    = Int16(number1!)
            product.number2    = Int16(number2!)
            product.number3    = Int16(number3!)
            product.weight     = Int16(weight)
            product.id         = Int32(nr)
            product.changeDate = Date.init()
        }
        return product
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
        rec.weight=123
        rec.searchTag="tag1"
    }
    func substring(string str: String, startPosition startEl: Int, len : Int) -> String {
        let startInd = str.index(str.startIndex, offsetBy: startEl)
        let end=min(startEl+len,str.count)
        let endInd = str.index(str.startIndex, offsetBy: end)
        let mySubstring = str[startInd..<endInd]  
        return String(mySubstring)
    }
    func substrng(left : String, len: Int) -> String {
        return String(left.prefix(len))
    }
    func substrng(right : String, len: Int) -> String {
        return String(right.suffix(len))
    }
    func filterData(searchText text : String, searchTable : DbTableNames, searchField field: SearchField)  {
        //let ageIs33Predicate = NSPredicate(format: "%K = %@", "age", "33")
        //let namesBeginningWithLetterPredicate = NSPredicate(format: "(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)")
        //(people as NSArray).filteredArrayUsingPredicate(namesBeginningWithLetterPredicate.predicateWithSubstitutionVariables(["letter": "A"]))
        // ["Alice Smith", "Quentin Alberts"]
        
        let searchField =  field.rawValue   //"producent"
        let sortField   =  field.rawValue     //"producent"
        let searchText  =  text
        
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
    func getReqest(searchTable : DbTableNames) -> NSFetchRequest<NSFetchRequestResult> {
        let reqest: NSFetchRequest<NSFetchRequestResult>
        switch searchTable {
        case .products:          reqest  = ProductTable.fetchRequest()
        case .toShop:            reqest  = ToShopProductTable.fetchRequest()
        case .basket:            reqest  = BasketProductTable.fetchRequest()
        case .shopingProduct:    reqest  = ShopingProductTable.fetchRequest()
        case .users:             reqest  = Users.fetchRequest()
        }
        return reqest
    }
    func save() {
        do {   try context.save()    }
        catch  {  print("Error saveing context \(error)")   }
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

