//
//  WebCretor.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 03/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
protocol WebCreatorDelegate {
    func webCreatorDataSource(forRow row: Int, forSection section: Int) -> ProductTable?
    func webCreatorNumberOfRows(forSection section: Int) -> Int
    func webCreatorNumberOfSections() -> Int
}
class WebCreator {
    struct WebColDescription {
        let header:      String
        let size:        String
        let rowContent:  String
        let footContent: String
    }
    struct SectionsDescription {
        var mainTitle = ""
        var sectionTitles = [String]()
        init() {
            mainTitle = "Koszyk produktów"
            sectionTitles = ["Przyprawy","Warzywa","Owoce"]
        }
    }
    var delegate: WebCreatorDelegate?
    
    var sectionInfo: SectionsDescription = SectionsDescription()
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
    
    var footerTitle = "Footer of page"
    var endHtml = ""
    var adresatHtml = ""
    var pictHtml = ""
    var ccsStyleExt = ""
    
    let headers     = ["Lp", "Nazwa produktu", "Cena"]
    let sizes       = ["5", "75", "*"]
    var rowContents  = ["col1", "col2", "col3"]
    var footContents = ["-", "Razem", ""]  //["-", "Razem produktów \(footerTitle)", "\(lp)"]
   
    var lang = "en"
    var htmlTablesCollection: [String] = [String]()
    
    func setSectionsTitles()  -> [String] {
        var value: [String] = [String]()
        let sectionCount=database.category.getTotalNumberOfSection()
        for i in 0..<sectionCount {
                let sectionName = database.category.getCategorySectionHeader(forSection: i)
                value.append(sectionName)
            }
        return value
    }
    
    init(polishLanguage: Bool) {
        self.polishLanguage = polishLanguage
        lang = polishLanguage ? "pl" : "en"
        sectionInfo.sectionTitles = setSectionsTitles()
        db=database.product.productArray

        //let allTitles = self.delegate?.webCreatorTitlesOfSerctions()
        //print("allTitles: \(allTitles ?? ["default value"])")
        //?? ["title0","title1","title2","title3"]
        
        self.i = 0
        self.lp = 0
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
        headHtml+="table tr:nth-child(even) {   background-color: #eee;  }\n"
        headHtml+="table tr:nth-child(odd)  {   background-color:#fff;   }\n"
        headHtml+="table th                 {   background-color: powderblue;  }\n"
        headHtml+="table#t02 table, th, td, thead, tfoot\n"
        headHtml+="{\n"
        headHtml+="    border: 0px solid black;\n"
        headHtml+="    text-align: left;\n"
        headHtml+="}\n"
        headHtml+="table#t01 thead {  color:black;}\n"
        headHtml+="table#t01 tfoot {  color:blue; }\n"
        if ccsStyleExt.count > 0 {
            headHtml+="\n\(ccsStyleExt)\n"
        }
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
    func craateHtmlTable(idTable: Int,  forSection section: Int, extraTitle: String = "") {
        var aTitle: String = "Section title"
        var tableHeaderHtml = ""
        var tableBodyHtml = ""
        var tableFooterHtml = ""
        
        aTitle = sectionInfo.sectionTitles[section]
        tableHeaderHtml="<table id=\"t0\(idTable)\">\n"
        tableHeaderHtml+="<caption><b>\(aTitle) \(extraTitle)</b></caption>\n"
        tableHeaderHtml+="<tr>"
        for tmp in webColsDescription {
            tableHeaderHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.header)</th>"
        }
        tableHeaderHtml+="</tr>\n"
        
        tableBodyHtml = getRowData(forSection: section)
        // ["-", "Razem produktów \(footerTitle)", "\(lp)"]
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
    var tableBodyHtml = ""
        let numOfRows = self.delegate?.webCreatorNumberOfRows(forSection: section)
        print("getRowData:\(numOfRows!), section:\(section)")
    for i in 0..<numOfRows! {
        if let prod = self.delegate?.webCreatorDataSource(forRow: i, forSection: section) {
            tableBodyHtml+="<tr>"
            tableBodyHtml+="<td  style=\"text-align: center;\">\(i+1)</td>"
            tableBodyHtml+="<td>\(prod.productName ?? "brak")</td>"
            tableBodyHtml+="<td>\(prod.producent ?? "nie ma")</td>"
            tableBodyHtml+="</tr>\n"
            }
        }
        return tableBodyHtml
    }
    func getFullHtml() -> String{
        let sectionsCount = self.delegate?.webCreatorNumberOfSections() ?? 1
        for i in 0..<sectionsCount {
            craateHtmlTable(idTable: i+1, forSection: i)
        }
//        craateHtmlTable(idTable: 1, forSection: 0)
//        craateHtmlTable(idTable: 2, forSection: 1)
//        craateHtmlTable(idTable: 3, forSection: 2)
        
        var value = headHtml+pictHtml+tableHeaderHtml
        for tmp in htmlTablesCollection {
            value += tmp
        }
        value += footerHtml+adresatHtml
    
        print(value)
        //print("headHtml:\(headHtml)")
        //print("tableHewaderHtml:\(tableHeaderHtml)")
        return value
    }
    func setCcsStyle(newStyleExtension style: String) {
        self.ccsStyleExt = style
    
    }
}