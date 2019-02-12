//
//  WebViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 07/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WebCreatorDelegate {

 
    //var product: [ProductTable] = [ProductTable]()
    //let sectionsGrups = database.category //.categoryGroups
    // categoryGroups
    
    // MARK: WebCreatorDelegate method
    func webCreatorTitlesOfSerctions() -> [String] {
        var value: [String] = [String]()
        for tmp in database.category.categoryArray {
            value.append(tmp.categoryName ?? "no category")
        }
        return ["tyt0","tyt1","tyt2","tyt3"] //value
    }
    func webCreatorNumberOfRows(forSection section: Int) -> Int {
        return  database.category.getCurrentSectionCount(forSection: section)
    }
    func webCreatorNumberOfSections() -> Int {
        return  database.category.getTotalNumberOfSection()
    }
    func webCreatorDataSource(forRow row: Int, forSection section: Int) -> ProductTable? {
        let  prodNumber=database.category.sectionsData[section].objects[row]
        let product = database.toShopProductArray[prodNumber].productRelation
        return product
    }

    //var delegate: WebCreatorDelegate?
    //database.delegate = self
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webCreator = WebCreator(polishLanguage: polishLanguage)
        webCreator.delegate = self
        let html = webCreator.getFullHtml()
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-[webView]-|",
                                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["webView": webView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[webView]-|",
                                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["webView": webView]))

        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
    }
    func saveToPdf() {
        //let web = 
        //webView.pdf
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
