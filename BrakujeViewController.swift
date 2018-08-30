//
//  BrakujeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
class Product: NSObject  {
    var producent: String
    var productName: String
    var weight: Int
    var eanCode: String
    var number1: Int
    var number2: Int
    var number3: Int
    
    override init()
    {
        self.producent = ""
        self.productName = ""
        self.weight = 0
        self.eanCode = ""
        self.number1 = 0
        self.number2 = 0
        self.number3 = 0
    }
    
     init(producent: String, productName: String, weight: Int, eanCode: String, number1: Int, number2: Int, number3: Int) {
        self.producent = producent
        self.productName = productName
        self.weight = weight
        self.eanCode = eanCode
        self.number1 = number1
        self.number2 = number2
        self.number3 = number3
    }
    func toString()
    {
        print("\(producent) :  \(productName) :  \(weight)  : \(eanCode) : \(number1) : \(number2) : \(number3)")
    }
}

class BrakujeViewController: UIViewController {
    var productList : [Product] = []
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
    
    
    @IBAction func analizaTap(_ sender: Any) {
       for i in 0..<picturesArray.count
       {
            let product = giveElement(with: i)
            product?.toString()
        }
    
   }
   func giveElement(with nr: Int) -> Product?
   {
            var product : Product?
            var weight: Int
            var eanCode: String
            
            let nazwa:String = picturesArray[nr]
            let elementy = nazwa.split(separator: "_", maxSplits: 11, omittingEmptySubsequences: false)
            print("---- \(nazwa)  ----")
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
                if let  w : Int = Int(str.prefix(upTo: index))
                {
                    weight = w
                }
                else
                {
                     weight = 0
                }
     
                
                let number3 = Int(elementy[elementy.count-1])
                let number2 = Int(elementy[elementy.count-2])
                let number1 = Int(elementy[elementy.count-3])
                eanCode = String(elementy[elementy.count-4])
                if Int(eanCode) == nil
                {
                    eanCode = "00000000"
                }
                
                product = Product(producent: producent, productName: productName as String, weight: weight, eanCode: eanCode, number1: number1 ?? 0, number2: number2 ?? 0, number3: number3 ?? 0)
            }
            return product
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
