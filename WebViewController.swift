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
    func webCreatorNumberOfRows() -> Int {
        return database.product.productArray.count
    }
    func webCreatorNumberOfSections() -> Int {
        return 1
    }
    func webCreatorDataSource(forRow row: Int, forSection section: Int) -> ProductTable {
        let product=database.product.productArray[row]
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
