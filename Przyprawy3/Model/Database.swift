//
//  Database.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 30.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//
import UIKit
import CoreData
protocol DatabaseDelegate: class {
    func updateGUI()
}
class Database  {
    var context: NSManagedObjectContext
    
    // seting delegate
    var delegate: DatabaseDelegate?
    //Entitis of project
    var category: CategorySeting=CategorySeting()
    
    //
    @objc var selectedCategory:CategoryTable? {
        didSet {
            print("Seting Category: \(selectedCategory?.categoryName ?? "")")
        }
    }
//    typealias CategorySetingType = (fetchedResultsArray: [CategoryTable], featchResultCtrl: NSFetchedResultsController<CategoryTable>, feachRequest :NSFetchRequest<CategoryTable>, sortDescriptor : NSSortDescriptor)
//    var categorySeting: CategorySetingType?
    
    

//    let categorySeting = (fetchedResultsArray: [CategoryTable], featchResultCtrl: NSFetchedResultsController<CategoryTable>, feachRequest :NSFetchRequest<CategoryTable>, sortDescriptor : NSSortDescriptor)

    // variable for ProductTable
    var productArray : [ProductTable] = []
    var featchResultCtrlProduct: NSFetchedResultsController<ProductTable>
    let feachProductRequest: NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
    let sortProductDescriptor = NSSortDescriptor(key: "productName", ascending: true)
    //var productTable = ProductTable(context: context)
    
    // variable for ShopingProductTable
    var shopingProductArray = [ShopingProductTable]()
    let featchResultCtrlShopingProduct: NSFetchedResultsController<ShopingProductTable>
    var feachShopingRequest:NSFetchRequest<ShopingProductTable> = ShopingProductTable.fetchRequest()
    let sortShopingProductDescriptor = NSSortDescriptor(key: "id", ascending: true)
    //var shopingProductTable : ShopingProductTable(context: context)

    // variable for ToShopProductTable
    var toShopProductArray = [ToShopProductTable]()
    let featchResultCtrlToShopProduct: NSFetchedResultsController<ToShopProductTable>
    var feachToShopProductRequest:NSFetchRequest<ToShopProductTable> = ToShopProductTable.fetchRequest()
    let sortToShopProductDescriptor = NSSortDescriptor(key: "id", ascending: true)
    //var shopingProductTable : ShopingProductTable(context: context)

    // variable for BasketProductTable
    var basketProductArray = [BasketProductTable]()
    let featchResultCtrlBasketProduct: NSFetchedResultsController<BasketProductTable>
    var feachBasketProductRequest:NSFetchRequest<BasketProductTable> = BasketProductTable.fetchRequest()
    let sortBasketProductDescriptor = NSSortDescriptor(key: "id", ascending: true)
    //var shopingProductTable : ShopingProductTable(context: context)
    
    var usersArray=[UsersTable]()

    func getParam(tableArrayWith dbName: DbTableNames) -> [AnyObject] {
        var myArray: [AnyObject]?
        switch dbName {
        case .products:
            myArray  = category.categoryArray
        case .categories:
            myArray  = productArray
        case .shopingProduct:
            myArray  = shopingProductArray
        case .toShop:
            myArray  = toShopProductArray
        case .basket:
            myArray  = basketProductArray
        case .users:
            print("ERROR: myArray  = userArray")
        }
        return myArray!
    }
//    func getParam(feachRequestlWith dbName: DbTableNames) -> NSFetchedResultsController<NSFetchRequestResult> {
//        //var featchResultCtrlCategory: NSFetchedResultsController<CategoryTable>
//        //feachCategoryRequest: NSFetchRequest<CategoryTable> = CategoryTable.fetchRequest()
//        var feachRequest: NSFetchRequest<NSFetchRequestResult>
//        switch dbName {
//            case .products:
//                feachRequest  = feachToShopProductRequest as! NSFetchRequest<NSFetchRequestResult>
//            case .categories:
//                feachRequest  = CategoryTable.fetchRequest()
//            case .toShop:
//                feachRequest  = ToShopProductTable.fetchRequest()
//            case .basket:
//                feachRequest  = BasketProductTable.fetchRequest()
//            case .shopingProduct:
//                feachRequest  = ShopingProductTable.fetchRequest()
//            case .users:
//                feachRequest = UsersTable.fetchRequest()
//        }
//        return feachRequest
//        }

    init(context: NSManagedObjectContext) {
        self.context = context
        
        
        // init Eniity buffors
        //product = ProductTable(context: context)
        //shoping = ShopingProductTable(context: context)
        
        feachProductRequest.sortDescriptors=[sortProductDescriptor]
        featchResultCtrlProduct=NSFetchedResultsController(fetchRequest: feachProductRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        feachShopingRequest.sortDescriptors=[sortShopingProductDescriptor]
        featchResultCtrlShopingProduct=NSFetchedResultsController(fetchRequest: feachShopingRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        feachToShopProductRequest.sortDescriptors=[sortToShopProductDescriptor]
        featchResultCtrlToShopProduct=NSFetchedResultsController(fetchRequest: feachToShopProductRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        feachBasketProductRequest.sortDescriptors=[sortBasketProductDescriptor]
        featchResultCtrlBasketProduct=NSFetchedResultsController(fetchRequest: feachBasketProductRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //feachCategoryRequest.sortDescriptors=[]
        //featchResultCtrlCategory=NSFetchedResultsController(fetchRequest: feachCategoryRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    func loadData()  {
        let request : NSFetchRequest<ProductTable> = ProductTable.fetchRequest()
        do {    let newProducyArray     = try context.fetch(request)
            // Todo- error out of range
            
            if newProducyArray.count > 0  {
                self.productArray = newProducyArray }
            else {
                print("Error loading empty data")
                self.productArray = newProducyArray
            }
        }
        catch { print("Error fetching data from context \(error)")   }
    }
    func loadData(tableNameType tabName : DbTableNames) {
        var request : NSFetchRequest<NSFetchRequestResult>?
        switch tabName {
        case .products       :
            request = ProductTable.fetchRequest()
        case .basket         :
            request = BasketProductTable.fetchRequest()
        case .shopingProduct :
            request = ShopingProductTable.fetchRequest()
        case .categories     :
            request = CategoryTable.fetchRequest()
        case .users          :
            request = UsersTable.fetchRequest()
        case .toShop         :
            request = ToShopProductTable.fetchRequest()
        }

        //request = ProductTable.fetchRequest()
        do {    let newArray     = try context.fetch(request!)
            // Todo- error out of range
            
            if newArray.count > 0  {
                //self.productArray = newArray as! [ProductTable] }
                switch tabName {
                    case .products       :
                    productArray = newArray as! [ProductTable]
                    case .basket         :
                    basketProductArray = newArray as! [BasketProductTable]
                    case .shopingProduct :
                    shopingProductArray = newArray as! [ShopingProductTable]
                    case .categories     :
                    category.categoryArray = newArray as! [CategoryTable]
                    case .users          :
                    usersArray = newArray as! [UsersTable]
                    case .toShop         :
                    toShopProductArray = newArray as! [ToShopProductTable]
                }
            }
            else {
                print("Error loading empty data")
                //self.productArray = newArray as! [ProductTable]
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
    func delTable(dbTableName : DbTableNames)  {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: dbTableName.rawValue)
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
        
        //productElem.parentCategory?.categoryName=database.selectedCategory?.categoryName
        productElem.parentCategory=database.selectedCategory
        productElem.categoryId = 1
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
            let number3 = Int(elementy[elementy.count-1]) ?? 0
            let number2 = Int(elementy[elementy.count-2]) ?? 0
            let number1 = Int(elementy[elementy.count-3]) ?? 0
            eanCode = String(elementy[elementy.count-4])
            if Int(eanCode) == nil {
                eanCode = "00000000"
            }
            product.producent  = producent
            product.productName=String(productName)
            product.eanCode    =  eanCode
            product.pictureName=pictureName
            product.number1    = Int32(number1)
            product.number2    = Int32(number2)
            product.number3    = Int32(number3)
            product.weight     = Int16(weight)
            product.id         = Int32(nr)
            product.changeDate = Date.init()
            product.checked    = false
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
    func filterData(searchText text : String, searchTable : DbTableNames, searchField field: SearchField, isAscending: Bool = true)  {
        //let ageIs33Predicate = NSPredicate(format: "%K = %@", "age", "33")
        //let namesBeginningWithLetterPredicate = NSPredicate(format: "(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)")
        //(people as NSArray).filteredArrayUsingPredicate(namesBeginningWithLetterPredicate.predicateWithSubstitutionVariables(["letter": "A"]))
        // ["Alice Smith", "Quentin Alberts"]
        var predicates = [NSPredicate]()
        
        let searchField =  field.rawValue
        let sortField   =  field.rawValue
        let searchText  =  text
        let findCategoryId = database.selectedCategory?.id ?? 1
        
        if searchTable == .products {
            let groupPredicate=NSPredicate(format: "%K = %@", "categoryId", "\(findCategoryId)")
            predicates.append(groupPredicate)
        }
       
        let reqest=getReqest(searchTable: searchTable) //.products
        if text.count>0 {
            let predicate=NSPredicate(format: "%K CONTAINS[cd] %@", searchField, searchText)
            predicates.append(predicate)
            let predicateAll=NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
            reqest.predicate=predicateAll
            let sortDeescryptor=NSSortDescriptor(key: sortField, ascending: isAscending)
            reqest.sortDescriptors=[sortDeescryptor]
        }

        do {
            let newSearchArray = (try context.fetch(reqest))
            switch searchTable {
            case .products:         productArray       = newSearchArray as! [ProductTable]
            case .shopingProduct:   basketProductArray = newSearchArray as! [BasketProductTable]
            case .toShop:           toShopProductArray = newSearchArray as! [ToShopProductTable]
            case .basket:           basketProductArray = newSearchArray as! [BasketProductTable]
            default:
                print("Table does not exist")
            }

            //productArray = newSearchArray as! [ProductTable]
        } catch  {
            print("Error feaching data from context \(error)")
        }
        delegate?.updateGUI()
    }
    //    func loadComputData() {
    //        var searchPredicate:NSPredicate?
    //
    //        var predicates = [NSPredicate]()
    //        let statusPredicate=NSPredicate(format: "isForSale=%@", true)
    //        predicates.append(statusPredicate)
    //        if let additionPredicate=searchPredicate {
    //            predicates.append(additionPredicate)
    //        }
    //        let predicate=NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
    //        if srtDescryptor.count>0 {
    //            reqest.sortDescryptor=sortDescryptor
    //        }
    //        tableView.reloadData()
    //    }
    func setSearchRequestArray(newProductArray: NSFetchRequest<NSFetchRequestResult>, searchTable : DbTableNames)
    {
//        switch searchTable {
//            case .products:  productArray = newProductArray as! [ProductTable]
//            case .shopingProduct:  basketProductArray = newProductArray as! [BasketProductTable]
//            case .toShop:  toShopProductArray = newProductArray as! [ToShopProductTable]
//            case .basket:  basketProductArray = newProductArray as! [BasketProductTable]
//        default:
//            print("Table does not exist")
//        }
        //productArray = newProductArray as! [ProductTable]
    }
    func getReqest(searchTable : DbTableNames) -> NSFetchRequest<NSFetchRequestResult> {
        let reqest: NSFetchRequest<NSFetchRequestResult>
        switch searchTable {
        case .products:
            reqest  = ProductTable.fetchRequest()
        case .toShop:
            reqest  = ToShopProductTable.fetchRequest()
        case .basket:
            reqest  = BasketProductTable.fetchRequest()
        case .shopingProduct:
            reqest  = ShopingProductTable.fetchRequest()
        case .categories:
             reqest  = CategoryTable.fetchRequest()
        case .users:
            reqest  = UsersTable.fetchRequest()
        }
        return reqest
    }
    func save() {
        do {   try context.save()    }
        catch  {  print("Error saveing context \(error)")   }
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
    func getEntityBuffor(databaseWithProduct database: Database) -> ProductTable {
        let product=ProductTable(context: database.context)
        return product
    }
    func addCategory(newCategoryValue category: CategoryType, idNumber id: Int) {
        let newCategory=CategoryTable(context: database.context)
        newCategory.categoryName=category.name
        newCategory.nameEN=category.nameEN
        newCategory.selectedCategory=category.selectedCategory
        newCategory.selectedCategory=category.selectedCategory
        newCategory.pictureEmoji=category.pictureName
        newCategory.id=Int16(id)
        
        //        let pict=UIImage(named: category.pictureName)
        //        let coder=NSCoder()
        //        coder.decodeData()
        newCategory.picture=nil
        self.category.categoryArray.append(newCategory)
        if category.selectedCategory {
            selectedCategory=newCategory
        }
        save()
    }
    func addToBasket(product : ProductTable) {
        let toShopProduct = ToShopProductTable(context: context)
        toShopProduct.changeDate=Date.init()
        toShopProduct.eanCode=product.eanCode
        toShopProduct.productRelation=product
        toShopProductArray.append(toShopProduct)        
    }

}
// New Class
class CategorySeting {
    var categoryArray: [CategoryTable] = []
    //var featchResultCtrlCategory: NSFetchedResultsController<CategoryTable>
    let feachCategoryRequest: NSFetchRequest<CategoryTable> = CategoryTable.fetchRequest()
    var sortCategoryDescriptor:NSSortDescriptor
    init()
    {
        categoryArray=[]
        sortCategoryDescriptor=NSSortDescriptor(key: "categoryName", ascending: true)
    }
}


