//
//  BrakujeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
// import CoreData

class BrakujeViewController: UIViewController {
    // var productList = [Product]()
    //let database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        //database.printPath()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
func initialProduct()
{
    
    }
    
    // MARK: - IBAction
    @IBAction func analizaTap(_ sender: Any) {
//       for i in 0..<picturesArray.count
//       {
//            let product = database.giveElement(with: i)
//        print("product.pictureName \(product.pictureName)")
//        product.toString()
//        }
   }
    
    @IBAction func getSubstr(_ sender: UIButton) {
        
        let str="0123456789"
        var str2=database.substring(string: str, startPosition: 8, len: 2)
        print("\(str2)")
        str2=database.substring(string: str, startPosition: 9, len: 2);
        print("\(str2)")
        
        //let str3="ABCDEFGHIJK"
        str2=database.substrng(left: str, len: 2)
        print("\(str2)")

        str2=database.substrng(right: str, len: 2)
        print("\(str2)")
    }
    
    @IBAction func WczytajBaze(_ sender: UIButton) {
        print("wczytaj baze")
        for i in 0..<picturesArray.count  {
            database.addProduct(withProductId: i)
            //database.wczytywanieElementowBazy(i)
        }
        //database.save()
     }
    @IBAction func wyswietlBaze(_ sender: UIButton) {
        //print("wyswietlBaze przed load : ilosc rekordow w bazie \(database.productArray.count)")
        //database.loadData()
       // print("wyswietlBaze po : ilosc rekordow w bazie \(database.productArray.count)")
    
        //let baseArray = database.productArray
        //var i=1
//        for rec in baseArray
//        {
//            database.toString(product: rec, nr: i)
//            i+=1
//        }
    }
    
    @IBAction func kasujTabele(_ sender: UIButton) {
        database.delTable(dbTableName: .products)
    }
    @IBAction func newAdd(_ sender: UIButton) {
        let prod=database.giveElement(withProduct: 0)
        let  prod2=database.giveElement(withProduct: 1)
        let  prod3=database.giveElement(withProduct: 2)
       
        database.addOneRecord(newProduct: prod)
        database.addOneRecord(newProduct: prod2)
        database.addOneRecord(newProduct: prod3)
    }
    @IBAction func addOneRecord(_ sender: UIButton) {
        var newProduct = ProductTable(context: database.context)
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add new record", message: "", preferredStyle: UIAlertController.Style.alert)
       
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            database.fill(product: &newProduct)
            newProduct.productName=textField.text
            database.addOneRecord(newProduct: newProduct)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField=field
            textField.placeholder="Add new record"
        }
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteLastRecord(_ sender: UIButton) {
     database.loadData()
     database.deleteOne()
        
    }
    @IBAction func infoButton(_ sender: UIButton) {
        let rec=database.productArray.count
        print("rozmiar productArray \(rec)")
        for i in 0..<rec
        {
            print("\(i) )\(database.productArray[i])")
        }
    }
    
    @IBAction func delDb2(_ sender: UIButton) {
        database.delTable(dbTableName: .shopingProduct)
    }
    @IBAction func newDb(_ sender: UIButton) {
        let shoping=ShopingProductTable(context: database.context)
        let product=ProductTable(context: database.context)
        product.eanCode="60920808"
    
        shoping.eanCode="60920808" //"60057064"
        shoping.productRelation=product
        database.shopingProductArray.append(shoping)
        database.save()
        
        
//        if let product=shoping.productRelation
//        {
//            product.pictureName=""
//        }
//
    }
    
    @IBAction func addNewCategory(_ sender: UIButton) {
        let newProduct=ProductTable(context: database.context)
        let newCategory=CategoryTable(context: database.context)
        newCategory.categoryName="Druga kategoria"
        newProduct.producent="CCCC"
        newProduct.productName="DDD"
        newProduct.parentCategory=newCategory
        database.save()
    }
    @IBAction func fillCategory(_ sender: Any) {
        for rec in categoriesData {
           database.addCategory(newCategoryValue: rec)
        }
    }
    
    @IBAction func delCategories(_ sender: UIButton) {
        database.delTable(dbTableName: .categories)
    }
    
    
    
    //    func fill(product rec : ProductTable)
    //    {
    //
    //        rec.producent="Knor"
    //        rec.productName="no product"
    //        rec.eanCode="88888"
    //        rec.id=222
    //        rec.pictureName="pic1"
    //        rec.number1=1
    //        rec.number2=2
    //        rec.number3=3
    //        rec.searchTag="tag1"
    //    }

//        let nazwa2:String = picturesArray[1]
//        let nazwa3:String = picturesArray[2]
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
