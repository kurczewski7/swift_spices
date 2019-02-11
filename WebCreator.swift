//
//  WebCretor.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 03/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
protocol WebCreatorDelegate {
    func webCreatorDataSource(forRow row: Int, forSection section: Int) -> ProductTable
    func webCreatorNumberOfRows() -> Int
    func webCreatorNumberOfSections() -> Int
}
class WebCreator {
    struct WebColDescription {
        let header:      String
        let size:        String
        let rowContent:  String
        let footContent: String
    }
    var delegate: WebCreatorDelegate?
    
    var webColsDescription: [WebColDescription] = []
    var db : [ProductTable] = []
    
    var i = 0
    var lp = 0
    var pictWidth  = 50
    var pictHeight = 50
    var headHtml = ""
    var bodyHtml = ""
    var footerHtml = ""
    let headerFilds = {}
    let contentField = {}
    let polishLanguage: Bool
    var tableHeaderHtml = ""
    var mainTitle = "Rachunek za filmy"
    var footerTitle = "Footer of page"
    var endHtml = ""
    var adresatHtml = ""
    var pictHtml = ""
    var ccsStyleExt = ""
    
    let headers     = ["Lp", "Tytul filmu", "Cena"]
    let sizes       = ["5", "75", "*"]
    var rowContents  = ["aaa", "bbb", "ccc"]
    var footContents = ["ddd", "eee", "fff"]
    var sectionTitles = ["Przyprawy","Warzywa","Owoce"]
    var lang = "en"
    var htmlTablesCollection: [String] = [String]()
    
    init(polishLanguage: Bool) {
        self.polishLanguage = polishLanguage
        lang = polishLanguage ? "pl" : "en"
        
        db=database.product.productArray
        self.i = 0
        self.lp = 0
        
        self.mainTitle      = "Koszyk produktów"
        self.footerTitle    = " \(sectionTitles[0])"
        self.rowContents     = ["Lp", sectionTitles[0], "Cena \(lp)"]
        self.footContents    = ["-", "Razem produktów \(footerTitle)", "\(lp)"]
        
        for i in 0..<headers.count {
            self.addWebCol(header: headers[i], size: sizes[i], rowContent: rowContents[i], footContent: footContents[i])
        }
        //<img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com">
        //<img src="programming.gif" alt="Computer man" style="width:48px;height:48px;">
        //pictHtml="<img src=\"https://www.w3schools.com/images/w3schools_green.jpg\" alt=\"HTML5 Icon\">"
        
        headHtml="<!DOCTYPE html><html lang=\"\(lang)\">\n<head><meta charset=\"utf-8\">\n<style>\n"
        headHtml+="table {width:100%;} \ntable, th, td {  border: 1px solid black;   border-collapse: collapse;  text-align: center;  }\n"
        headHtml+="th {padding: 5px;text-align: center;}\n"
        headHtml+="td {padding: 5px;text-align: left;}\n"
        headHtml+="img {width: 100px; height: 100px;}\n"
        headHtml+="table#t01 tr:nth-child(even) {   background-color: #eee;  }\n"
        headHtml+="table#t01 tr:nth-child(odd)  {   background-color:#fff;   }\n"
        headHtml+="table#t01 th                 {   background-color: gray;  }\n"
        headHtml+="table#t02 table, th, td, thead, tfoot\n"
        headHtml+="{\n"
        headHtml+="    border: 0px solid black;\n"
        headHtml+="    text-align: left;\n"
        headHtml+="}\n"
        headHtml+="table#t01 thead {  color:black;}\n"
        headHtml+="table#t01 tfoot {  color:blue; }\n"
        headHtml+="</style>\n"
        headHtml+="</head>\n"
        headHtml+="<body>\n"
        headHtml+="<img src=\"owoce_08_b.jpg\" alt=\"HTML5 Icon\">"
        headHtml+="<img src=\"https://www.w3schools.com/images/w3schools_green.jpg\" alt=\"HTML5 Icon\">"
        
        endHtml+="</body>"
        endHtml+="</html>"


    }
    func addWebCol(header: String, size: String, rowContent: String, footContent: String) {
        let value: WebColDescription = WebColDescription(header: header, size: size, rowContent: rowContent, footContent: footContent)
        webColsDescription.append(value)
    }
    func craateHtmlTable(idTable: Int, aTitle: String, forSection section: Int) {
        var tableHeaderHtml = ""
        var tableBodyHtml = ""
        var tableFooterHtml = ""

        tableHeaderHtml="<table id=\"t\(idTable)\">\n"
        tableHeaderHtml+="<caption>\(aTitle): <b>77</b></caption>\n"
        tableHeaderHtml+="<tr>"
        for tmp in webColsDescription {
            tableHeaderHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.rowContent)</th>"
        }
        tableHeaderHtml+="</tr>\n"
        
        tableBodyHtml = getRowData(forSection: section)
        
        tableFooterHtml+="<tfoot>\n"
        tableFooterHtml+="<tr>\n"
        for tmp in webColsDescription {
            tableFooterHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.footContent)</th>\n"
        }
        tableFooterHtml+="</tr>\n"
        tableFooterHtml+="</tfoot>\n"
        tableFooterHtml+="</table>"
        self.htmlTablesCollection.append(tableHeaderHtml + tableBodyHtml + tableFooterHtml)
    }

    func getRowData(forSection section: Int) -> String {
    //var rowData=["AAAA BBBB\(100+1)","\(2+2)","\(2+200)"]
    //rowData.append("<#T##Sequence#>")
    var tableBodyHtml = ""
    let numOfRows = self.delegate?.webCreatorNumberOfRows()
    for i in 0..<numOfRows! {
        let prod = self.delegate?.webCreatorDataSource(forRow: i, forSection: section)
        tableBodyHtml+="<tr>"
        tableBodyHtml+="<td  style=\"text-align: center;\">\(i+1)</td>"
        tableBodyHtml+="<td>\(prod?.productName ?? "brak")</td>"
        tableBodyHtml+="<td>\(prod?.producent ?? "nie ma")</td>"
        tableBodyHtml+="</tr>\n"
        }
        return tableBodyHtml
    }
    func getFullHtml() -> String{
        //getRowData(forSection: 0)
        craateHtmlTable(idTable: 1, aTitle: "Pierwsza", forSection: 0)
         craateHtmlTable(idTable: 1, aTitle: "Druga", forSection: 0)
        let value = headHtml+pictHtml+tableHeaderHtml + htmlTablesCollection[0] + htmlTablesCollection[1] + footerHtml+adresatHtml
        print(value)
        //print("headHtml:\(headHtml)")
        //print("tableHewaderHtml:\(tableHeaderHtml)")
        return value
    }
    func setCcsStyle(newStyleExtension style: String) {
        self.ccsStyleExt = style
    
    }
}
