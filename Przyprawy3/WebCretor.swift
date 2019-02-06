//
//  WebCretor.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 03/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
class WebCreator {
    struct WebColDescription {
        let header:      String
        let size:        String
        let rowContent:  String
        let footContent: String
    }
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
    
    let headers     = ["Lp", "Tytul filmu", "Cena"]
    let sizes       = ["5", "75", "*"]
    var rowContents  = ["aaa", "bbb", "ccc"]
    var footContents = ["ddd", "eee", "fff"]
    var sectionTitles = ["Przyprawy","Warzywa","Owoce"]
    var lang = "en"
    
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
        tableHeaderHtml="<table id=\"t01\">\n"
        tableHeaderHtml+="<caption>\(mainTitle): <b>77</b></caption>\n"
        tableHeaderHtml+="<tr>"
        for tmp in webColsDescription {
           tableHeaderHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.rowContent)</th>"
        }
        tableHeaderHtml+="</tr>\n"


        footerHtml+="<tfoot>\n"
        footerHtml+="<tr>\n"
        for tmp in webColsDescription {
           footerHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.footContent)</th>\n"
        }
        footerHtml+="</tr>\n"
        footerHtml+="</tfoot>\n"
        footerHtml+="</table>"
        
        
        
        endHtml+="</body>"
        endHtml+="</html>"

        
    }
    func addWebCol(header: String, size: String, rowContent: String, footContent: String) {
        let value: WebColDescription = WebColDescription(header: header, size: size, rowContent: rowContent, footContent: footContent)
        webColsDescription.append(value)
    }
    
func getRowData() {
    
    var rowData=["AAAA BBBB\(100+1)","\(2+2)","\(2+200)"]
    //rowData.removeAll()
    //
    rowData.append("<#T##Sequence#>")
    
    for i in 0..<30 {
        bodyHtml+="<tr>"
        bodyHtml+="<td  style=\"text-align: center;\">\(i+1)</td>"
        bodyHtml+="<td>\(db[i].productName ?? "brak")</td>"
        bodyHtml+="<td>\(db[i].producent ?? "nie ma")</td>"
        bodyHtml+="</tr>\n"
        }
    }
    func getFullHtml() {
        getRowData()
        let value = headHtml+pictHtml+tableHeaderHtml+bodyHtml+footerHtml+adresatHtml
        print(value)
        //print("headHtml:\(headHtml)")
        //print("tableHewaderHtml:\(tableHeaderHtml)")
    }
}
