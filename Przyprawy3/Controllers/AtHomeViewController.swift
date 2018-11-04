//
//  AtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AtHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var numberOfRow = 0
    var instantSearch = true
    var productMode = true
    

    let sg = UISegmentedControl(items: segmentValues)
    
    @IBOutlet var searchedBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         initSearchBar(self.searchedBar)
         database.loadData()
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        database.filterData(searchText: "aMi", searchTable: .products, searchField: .Producent)
        table.reloadData()
        
    }
    // MARK - TableView metod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return picturesArray.count
        return database.productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AtHomeCell

        cell.categoryLabel.text = database.productArray[indexPath.row].productName?.capitalized(with: nil)   //database.productArray[indexPath.row].pictureName
        cell.producentLabel.text =  database.productArray[indexPath.row].producent?.uppercased()     //"Winiary"
        cell.descriptionLabel.text =  String(database.productArray[indexPath.row].weight).lowercased()+"g"                       //picturesArray[indexPath.row]
        cell.productPicture.image = UIImage(named:  database.productArray[indexPath.row].pictureName!)       // picturesArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        numberOfRow=indexPath.row
        performSegue(withIdentifier: "goToAtHome", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goToAtHome"
        {
            let nextVC=segue.destination as! DetailAtHomeViewController
            nextVC.numberOfRow=numberOfRow
            nextVC.productImageName=database.productArray[numberOfRow].pictureName!                //picturesArray[numberOfRow]
            nextVC.productTitle=database.productArray[numberOfRow].productName!                     //"Przyprawa aaa"
            nextVC.productSubtitle=database.productArray[numberOfRow].producent!                                                                //"Knor"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SearchBar metod
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked \(searchBar.text!)")
        changeMyView()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("changed \(searchBar.text!)")
        changeMyView()
    }
    
    // MARK: - My own methods
    func changeMyView()
    {
        if(instantSearch)
        {
            print("Now refresh UI")
        }
    }
    func initSearchBar(_ searchBar: UISearchBar)
    {
        searchBar.placeholder=self.giveProductPrompt(with: true)[0]

        sg.removeAllSegments()
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[0], at: 0, animated: false)
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[1], at: 1, animated: false)
        sg.selectedSegmentIndex = 0
        //segmetedControl.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents:)
        //addTarget(self, action: #selector(changeWebView), for: .valueChanged)
        sg.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        self.table.tableHeaderView = sg
        
        table.sectionHeaderHeight = 100
        
        //self.table.tableHeaderView?.backgroundColor=UIColor.yellow
        //let ssgg = self.table.tableHeaderView as! UISegmentedControl
    }
    @objc func segmentedControlValueChanged(segment: UISegmentedControl)
    {
        print("segment changed \(segment.selectedSegmentIndex)")
        if (searchedBar.text?.isEmpty)!
        {
            searchedBar.placeholder =  giveProductPrompt(with: true)[segment.selectedSegmentIndex]
        }
    }    
    func giveProductPrompt(with isPlaceholder:Bool) -> [String]
    {
        var myPrompt = [String]()
        if(polishLanguage)
        {
           myPrompt = (isPlaceholder ? ["Wyszukaj produkt 🌶","Wyszukaj producenta 🔧"] : ["🌶 Produkt ","🔧 Producent "] )
        }
        else
        {
            myPrompt = (isPlaceholder ? ["Find your product 🌶","Find your producent 🔧"] : ["🌶 Product ","🔧 Producent "] )
        }
        return myPrompt
    }

        
//        searchBar.showsScopeBar=true
//        searchBar.scopeButtonTitles=["name", "Producenr","gggg"]
//        searchBar.selectedScopeButtonIndex=0
        
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }

}
