//
//  BrakujeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class BrakujeViewController: UIViewController {
    var productList = [Product]()
    let database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        database.printPath()
        
        //productList.append(<#T##newElement: Product##Product#>)

        // Do any additional setup after loading the view.
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
       for i in 0..<picturesArray.count
       {
            let product = giveElement(with: i)
            product?.toString()
        }
   }
    @IBAction func WczytajBaze(_ sender: UIButton) {
        for i in 0..<picturesArray.count
        {
            let product = giveElement(with: i)
            database.addProduct(productElem: product!, id: i, saving: true)
    
            product?.toString()
        }
        database.save()
    }
    @IBAction func wyswietlBaze(_ sender: UIButton) {
        database.loadData()
        print("ilosc rekordow w bazie \(database.productArray.count)")
    
        let baseArray = database.productArray
        var i=1
        for rec in baseArray
        {
            database.toString(product: rec, nr: i)
            i+=1
        }        
    }
    
    @IBAction func kasujTabele(_ sender: UIButton) {
        database.deleteAllData(entity: DbTableNames.produkty.rawValue)
    }
    func giveElement(with nr: Int) -> Product?
   {
            var product : Product?
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
 
    @IBAction func addOneRecord(_ sender: UIButton) {
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add new record", message: "", preferredStyle: UIAlertController.Style.alert)
        let newProduct = ProductTable(context: self.database.context!)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.fill(product: newProduct)
            newProduct.productName=textField.text
            self.database.productArray.append(newProduct)
            self.database.save()
            
            //            self.database.fillTestData()
            //            self.database.productArray.append(self.database.product)
            //self.productList.append(newProduct)
            //self.database.product.productName=textField.text
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField=field
            textField.placeholder="Add new record"
        }
        present(alert, animated: true, completion: nil)
        
    }
    func fill(product rec : ProductTable)
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
    @IBAction func deleteLastRecord(_ sender: UIButton) {
        
        
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let rec=database.productArray.count
        print("rozmiar productArray \(rec)")
        for i in 0..<rec
        {
            print("\(i) )\(database.productArray[i])")
        }
    }
    
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
