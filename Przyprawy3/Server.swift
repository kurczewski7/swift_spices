//
//  Server.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 13/03/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import UIKit

class Server {
    var urlString: String = ""
    var pictureUrlString = ""
    var url: URL? = nil
    var urlRequest:URLRequest? = nil
    var task: URLSession? = nil

    func makeSqlTxt(database db : Database) -> String  {
    
//        CREATE TABLE `product_table` (
//            `categoryId` int(10) DEFAULT NULL,
//            `changeDate` date NOT NULL,
//            `checked` tinyint(1) NOT NULL,
//            `eanCode` text COLLATE utf8_polish_ci NOT NULL,
//            `fullPicture` text COLLATE utf8_polish_ci NOT NULL,
//            `id` int(10) NOT NULL,
//            `number1` int(10) NOT NULL,
//            `number2` int(10) NOT NULL,
//            `number3` int(10) NOT NULL,
//            `pictureName` text COLLATE utf8_polish_ci NOT NULL,
//            `producent` text COLLATE utf8_polish_ci NOT NULL,
//            `productName` text COLLATE utf8_polish_ci NOT NULL,
//            `searchTag` text COLLATE utf8_polish_ci NOT NULL,
//            `smallPicture` text COLLATE utf8_polish_ci NOT NULL,
//            `weight` int(10) NOT NULL
//        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
        
        var isNumber: Bool = false 
        var tekst: String = ""
        var tx: [String] =  ["","","","","","","","","","","","","","",""]
        let integerFields: [Int] = [0, 2, 5, 6, 7, 8, 14]

//        tekst =  "INSERT INTO `dvds` (`filmId`, `title`, `filmDirector`, `actors`, `type`, `filmDescription`, `filmImageName`, `youtubeUrl`, `price`, `isLiked`) VALUES \n"
        
        
        tekst = "INSERT INTO `product_table` (`categoryId`, `changeDate`, `checked`, `eanCode`, `fullPicture`, `id`, `number1`, `number2`, `number3`, `pictureName`, `producent`, `productName`, `searchTag`, `smallPicture`, `weight`) VALUES\n"
        
        let dbArray = db.product.productArray
        for i in 0..<dbArray.count   {
            tx[0] = "\(dbArray[i].categoryId)"            
            tx[1] =  getStringDate(forDate: dbArray[i].changeDate)                                           //"\(dbArray[i].changeDate ?? Date())"
            tx[2] = "\(dbArray[i].checked)"
            tx[3] = "\(dbArray[i].eanCode ?? "")"
            tx[4] =  "pict_\(dbArray[i].eanCode ?? "")"
            tx[5] = "\(dbArray[i].id)"
            tx[6] = "\(dbArray[i].number1)"
            tx[7] = "\(dbArray[i].number2)"
            tx[8] = "\(dbArray[i].number3)"
            tx[9] =  dbArray[i].pictureName ?? "pict00"
            tx[10] = dbArray[i].producent ?? ""
            tx[11] = dbArray[i].productName ?? ""
            tx[12] = dbArray[i].searchTag ?? ""
            tx[13] = "pict_\(dbArray[i].eanCode ?? "")"
            tx[14] = "\(dbArray[i].weight)"

            tekst += "("
            for t in 0..<tx.count-1 {
                isNumber = find(forArray: integerFields, findElement: t)
                tekst += (isNumber ? "" : "'")+"\(tx[t])"+(isNumber ? "," :"', ")
            }
            isNumber = find(forArray: integerFields, findElement: tx.count-1)
            tekst += (isNumber ? "" : "'")+"\(tx[tx.count-1])"+(isNumber ? "" :"'")
            tekst += (i < dbArray.count-1) ? "),  \n " : "); \n"
        }
        return tekst
    }
    func find(forArray arr: [Int], findElement el: Int)  -> Bool {
        var val = false
        for tmp in arr {
            if tmp == el {
                val = true
            }
        }
        return val
    }
    func getStringDate(forDate myDate: Date?) -> String {
        var date: Date!
        if myDate == nil {
            date = Date()
        }
        else {
            date = myDate
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let todaysDate = dateFormatter.string(from: date)
        print(todaysDate)
        return todaysDate
    }
}
 //   func xxx() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
//        let date = Date()
//        print(date)
        
//        let date : Date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let todaysDate = dateFormatter.string(from: date)
//        print(todaysDate)
    
//    }

    
    
//    var currentDay="2017-06-11"
//    var dvds = [Dvd]()
//    var currencies = [String: Double]()
//    var valuteExchange: [String: Double] = ["USD": 0.0, "EUR" : 0.0]
//    var errrorDvdsNet: Bool = false
//    var errorCurrencyNet: Bool = false
    
    // exchange rate link NBP http://api.nbp.pl/api/exchangerates/rates/c/eur/2017-06-14/?format=json
    // var nbpFullExchangeLink = "http://api.nbp.pl/api/exchangerates/tables/c/?format=json"
    
//    init() {
//        self.urlString = "http://skurczewski1.myqnapcloud.com/dvdshop/api.php/dvds/"
//        self.pictureUrlString = "http://skurczewski1.myqnapcloud.com/dvdshop/img/"
//        getValuteExchangeRate()
//        getLatestDvds()
//        print("Status error NET dvds:\(self.errrorDvdsNet), valuta: \(self.errorCurrencyNet)")
//    }
//
//    func getLatestDvds() {
//        print("-------- Geting Film data from NET ---------")
//        print("url:\(self.urlString)")
//        guard let url = URL(string: urlString) else {
//            return        }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request, completionHandler:
//        { (data, response, error) -> Void in
//
//            if let error = error {
//                print(error)
//                self.errrorDvdsNet=true
//                return   }
//            // Parse JSON data
//            if let data = data {
//                self.dvds = self.parseJsonData(data: data)
//            }
//        }
//        )
//        task.resume()
//    }
//
//    func getValuteExchangeRate() {
//        print("-------- Geting currency rate from NET (USD, EUR) ---------")
//        let urlCurrencyString = self.nbpFullExchangeLink
//        print("url:\(urlCurrencyString)")
//        guard let url = URL(string: urlCurrencyString) else {
//            return      }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request, completionHandler:
//        { (data, response, error) -> Void in
//            if let error = error {
//                print(error)
//                self.errorCurrencyNet=true
//                return   }
//
//            // Parse JSON data
//            if let data = data {   self.parseJsonValuteData(data: data)    }
//        })
//        task.resume()
//    }
//
//
//    func parseJsonData(data: Data) -> [Dvd] {
//        var dvds = [Dvd]()
//        do {
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
//
//            // Parse JSON data
//            let jsonDvds = jsonResult?["dvds"] as! [AnyObject]
//            for jsonDvd in jsonDvds {
//                let dvd = Dvd()
//
//                dvd.actors          = jsonDvd["title"] as! String
//                dvd.filmDescription = jsonDvd["filmDescription"] as! String
//                dvd.filmDirector    = jsonDvd["filmDirector"] as! String
//                dvd.filmId          = jsonDvd["filmId"] as! String
//                dvd.filmImageName   = jsonDvd["filmImageName"] as! String
//                dvd.filmImageData   =  getPictureWeb(pictureName: dvd.filmImageName)
//                dvd.isLiked         = (jsonDvd["isLiked"] as! String)=="1" ? true : false
//                dvd.price           = jsonDvd["price"] as! String
//                dvd.title           = jsonDvd["title"] as! String
//                dvd.type            = jsonDvd["type"] as! String
//                dvd.youtubeUrl      = jsonDvd["youtubeUrl"] as! String
//                dvds.append(dvd)
//            }
//        } catch {   print(error)
//            self.errrorDvdsNet=true }
//        return dvds
//    }
//
//    func parseJsonValuteData(data: Data)  {
//        var elem: [String: Any]
//        currencies.removeAll(keepingCapacity: false)
//        var key: String
//        var value: Double = 0.0
//
//        do {
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
//            if let array = jsonResult as? [Any] {
//                if let firstObject=array.first as? [String: Any]{
//                    let day=firstObject["tradingDate"]
//                    self.currentDay = day as? String ?? "2017-06-13"
//                    let rates = firstObject["rates"] as?  [Any]
//                    if let  maxElem = rates?.count {
//                        for i in 0..<maxElem {
//                            elem = rates![i] as! [String : Any]
//                            key = elem["code"] as! String
//                            value = elem["ask"] as! Double
//                            self.currencies[key] = value
//                            self.currencies.updateValue(elem["ask"] as! Double, forKey: elem["code"] as! String)
//                            print("$ \(self.currentDay)   \(elem["code"] ?? 0.0):  \(elem["ask"] ?? 0.0)")
//                            self.valuteExchange["USD"]=self.currencies["USD"] ?? 0.0
//                            self.valuteExchange["EUR"]=self.currencies["EUR"] ?? 0.0
//                        }
//                    }
//                }
//            }
//
//        } catch {   self.errorCurrencyNet=true
//            print(error)     }
//        return
//
//        // Parse JSON data
//
//    }
//
//
//    //                dvd.actors          = jsonDvd["title"] as! String
//    //                dvd.filmDescription = jsonDvd["filmDescription"] as! String
//    //                dvds.append(dvd)
//
//    func makeJsonTxt(database db : Database) -> String {
//        var tekst: String = ""
//        var tx: [String] = ["","","","","","","","","","",""]
//        let brak = "brak"
//
//        tekst =  "{ \"dvds\" : ["
//        for i in 0..<db.flimsbaseFull.count  {
//            tx[0] = "  {\"filmId\":\"\(db.flimsbaseFull[i].filmId ??  brak)\""
//            tx[1] = ", \"title\":\"\(db.flimsbaseFull[i].title ?? "")\""
//            tx[2] = ", \"filmDirector\":\"\(db.flimsbaseFull[i].filmDirector ?? "")\""
//            tx[3] = ", \"actors\":\"\(db.flimsbaseFull[i].actors ?? "")\""
//            tx[4] = ", \"type\":\"\(db.flimsbaseFull[i].type ?? "")\""
//            tx[5] = ", \"filmDescription\":\"\(db.flimsbaseFull[i].filmDescription ?? "")\""
//            tx[6] = ", \"filmImageName\":\"\(db.flimsbaseFull[i].pictureName ?? "")\""
//            tx[7] = ", \"youtubeUrl\":\"\(db.flimsbaseFull[i].youtubeUrl ?? "")\""
//            tx[8] = ", \"price\":\"\(db.flimsbaseFull[i].price )\""
//            tx[9] = ", \"isLiked\":\"\(db.flimsbaseFull[i].isLiked ? "1" : "0")\"}"
//            tx[10] = (i < db.flimsbaseFull.count-1) ? ",  \n " : " \n"
//            for t in 0..<tx.count {
//                tekst += tx[t]
//            }
//        }
//        tekst += "]}"
//        return tekst
//    }
//
//    func makeSqlTxt(database db : Database) -> String  {
//        var tekst: String = ""
//        var tx: [String] = ["","","","","","","",""]
//        let brak = "brak"
//        
//        tekst =  "INSERT INTO `dvds` (`filmId`, `title`, `filmDirector`, `actors`, `type`, `filmDescription`, `filmImageName`, `youtubeUrl`, `price`, `isLiked`) VALUES \n"
//
//        for i in 0..<db.flimsbaseFull.count  {
//            tx[0] = db.flimsbaseFull[i].filmId ??  brak
//            tx[1] = db.flimsbaseFull[i].title ?? ""
//            tx[2] = db.flimsbaseFull[i].filmDirector ?? ""
//            tx[3] = db.flimsbaseFull[i].actors ?? ""
//            tx[4] = db.flimsbaseFull[i].type ?? ""
//            tx[5] = db.flimsbaseFull[i].filmDescription ?? ""
//            tx[6] = db.flimsbaseFull[i].pictureName ?? ""
//            tx[7] = db.flimsbaseFull[i].youtubeUrl ?? ""
//            print("SQL picName:"+db.flimsbaseFull[i].pictureName!)
//
//            tekst += "("
//            for t in 0..<tx.count {
//                tekst += "'\(tx[t])', "
//            }
//            tekst += kantor.doubleToString(db.flimsbaseFull[i].price)+", "
//            tekst += db.flimsbaseFull[i].isLiked ? "1" : "0"
//            tekst += (i < db.flimsbaseFull.count-1) ? "),  \n " : "); \n"
//        }
//        return tekst
//    }
//
//    func getPictureWeb(pictureName: String) -> Data? {
//        var data:Data?
//        let url = URL(string: "\(pictureUrlString)\(pictureName).jpg")
//
//        do {  data = try Data(contentsOf: url!)
//        } catch {
//            data = nil
//            if let img = UIImage(named: "placeholder.jpg"){
//                data = UIImagePNGRepresentation(img)
//            }
//        }
//        return data
//    }
//
//    func fillDatabaseFromWeb() {
//
//    }


