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
    
    var i = 0
    var lp = 0
    var headHtml = ""
    var bodyHtml = ""
    var footerHtml = ""
    let headerFilds = {}
    let contentField = {}
    let polishLanguage: Bool
    var tableHeaderHtml = ""
    var mainTitle = "Rachunek za filmy"
    var footerTitle = "AAAAA"
    var endHtml = ""
    var adresatHtml = ""
    
    let headers     = ["Lp", "Tytul filmu", "Cena"]
    let sizes       = ["5", "75", "*"]
    var rowContents  = ["aaa", "bbb", "ccc"]
    var footContents = ["ddd", "eee", "fff"]
    
    
    
   
    init(polishLanguage: Bool) {
        self.i = 0
        self.lp = 0
        self.polishLanguage = polishLanguage
        self.mainTitle      = "Rachunek za filmy \(lp)"
        self.footerTitle    = "Suma za filmy \(lp)"
        self.rowContents     = ["Lp", "Tytul filmu\(lp)", "Cena \(lp)"]
        self.footContents    = ["-", "Suma za filmy \(footerTitle)", "\(lp)"]
        
        for i in 0..<headers.count {
            self.addWebCol(header: headers[i], size: sizes[i], rowContent: rowContents[i], footContent: footContents[i])
        }
        
        headHtml="<!DOCTYPE html><html>\n<head>\n<style>\n"
        headHtml+="table {width:100%;} \ntable, th, td {  border: 1px solid black;   border-collapse: collapse;  text-align: center;  }\n"
        headHtml+="th {padding: 5px;text-align: center;}\n"
        headHtml+="td {padding: 5px;text-align: left;}\n"
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
        
        tableHeaderHtml="<table id=\"t01\">\n"
        tableHeaderHtml+="<caption>\(mainTitle): <b>77</b></caption>\n"
        tableHeaderHtml+="<tr>"
        for tmp in webColsDescription {
           tableHeaderHtml+="<th style=\"width:\(tmp.size)%\">\(tmp.rowContent)</th>"
        }
        tableHeaderHtml+="</tr>\n"


        footerHtml+="<tfoot>\n"
        footerHtml+="1111<tr>2222\n"
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
    //---------------------------------------
    //        footerHtml+="<tr>"
    //        footerHtml+="<td></td>"
    //        footerHtml+="<td>\(2+2)</td>"
    //        footerHtml+="<td></td>"
    //        footerHtml+="</tr>"

    //        footerHtml+="<th style=\"width:\(sizes[0])%\">\(footContent[0])</th>\n"
    //        footerHtml+="<th style=\"width:\(sizes[1])%\">\(footContent[2])/th>\n"
    //        footerHtml+="<th style=\"width:\(sizes[1])%\">\(footContent[3])</th>\n"
    //footerHtml+="<tr>"
    //tableHewaderHtml+="<th style=\"width:5%\">\(headers[0])</th>"
    //tableHewaderHtml+="<th style=\"width:75%\">\(headers[1])</th>"
    //tableHewaderHtml+="<th>\(headers[1])</th>"

    
    
func getRowData() {
    
    let rowData=["AAAA BBBB\(100+1)","\(2+2)","\(2+200)"]
    //headHtml+="<tr>"
    
    for i in 0..<10 {
        bodyHtml+="<tr>"
        bodyHtml+="<td  style=\"text-align: center;\">\(i+1)</td>"
        bodyHtml+="<td>\(rowData[0])</td>"
        bodyHtml+="<td>\(rowData[1])</td>"
        bodyHtml+="</tr>\n"
        }
    }
    func getFullHtml() {
        getRowData()
        let value = headHtml+tableHeaderHtml+bodyHtml+footerHtml+adresatHtml
        print(value)
        //print("headHtml:\(headHtml)")
        //print("tableHewaderHtml:\(tableHeaderHtml)")
    }
}
