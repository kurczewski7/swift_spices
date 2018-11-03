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
        let str2=database.substring(string: str, startEl: 3, len: 5)
        print("\(str2)")
        
        let str3="ABCDEFGHIJK"
        let str4=database.substrng(left: str, len: 2)
        print("\(str4)")
        
        let str5=database.substrng(right: str, len: 2)
        print("\(str5)")
    }
    
    @IBAction func WczytajBaze(_ sender: UIButton) {
        print("wczytaj baze")
        for i in 0..<10  {
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
      database.delTable()
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
