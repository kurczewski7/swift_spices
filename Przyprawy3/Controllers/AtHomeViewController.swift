//
//  AtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//


// self.table.tableHeaderView = sg
import UIKit

class AtHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DatabaseDelegate {
    var numberOfRow = 0
    var instantSearch = true
    var productMode = true
    var selectedSegmentIndex = 0
    var eanMode: Bool = false
    
    let sg = UISegmentedControl(items: segmentValues)
    var numberOfRecords = -1

    @IBOutlet var searchedBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    // DatabaseDelegate method
    func updateGUI() {
        table.reloadData()
    }
    func getNumberOfRecords(numbersOfRecords recNo: Int, eanMode: Bool) {
        self.numberOfRecords=recNo
        self.eanMode=eanMode
    }

    override func viewDidLoad() {
        
        // DatabaseDelegate method
        super.viewDidLoad()
         initSearchBar(self.searchedBar)
        database.loadData(tableNameType: .products)
         database.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if numberOfRecords == 0  && eanMode{
            let alertController=UIAlertController(title: "Product not found", message: "Product EAN code \(database.scanerCodebarValue) not found in database", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default)
            let actionCanel=UIAlertAction(title: "Anuluj", style: .cancel)
            alertController.addAction(actionCanel)
            alertController.addAction(actionOK)
            present(alertController, animated: true)
        }
    }

    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        database.filterData(searchText: "aMi", searchTable: .products, searchField: .Producent)
        //table.reloadData()
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        database.searchEanCode()
        //table.reloadData()
    }
    
    @IBAction func keyboardModeButton(_ sender: UIBarButtonItem) {
        searchedBar.resignFirstResponder()
    }
    // MARK - TableView metod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return picturesArray.count
        return database.product.productArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AtHomeCell
        let product=database.product.productArray[indexPath.row]

        cell.categoryLabel.text = product.productName?.capitalized(with: nil) ?? "No product"
        //database.productArray[indexPath.row].pictureName
         //cell.producentLabel?.font.withSize(25)
        cell.producentLabel.text = product.producent?.uppercased()  ?? "No producent"
        cell.descriptionLabel.text =  String(product.weight).lowercased()+"g"                       //picturesArray[indexPath.row]
        cell.productPicture.image = UIImage(named:  product.pictureName ?? "question-mark")
        cell.accessoryType =  product.checked ? .checkmark : .none
        cell.producentLabel?.font.withSize(25)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        numberOfRow=indexPath.row
        performSegue(withIdentifier: "goToAtHome", sender: self)
    }
    // MARK : Editing style
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let currCell=tableView.cellForRow(at: indexPath)
        let isChecked = (currCell?.accessoryType == .checkmark)
        let checkAction=UITableViewRowAction(style: .default, title: " 🧺\nDo koszyka", handler:
        {(action, indexPath) -> Void in
            currCell?.accessoryType = .checkmark
            database.product.productArray[indexPath.row].checked = true
            database.addToBasket(product: database.product.productArray[indexPath.row])
            database.save()
        })
        let uncheckAction=UITableViewRowAction(style: .destructive, title: "❎\nUsuń z koszyka ", handler:
        { (action, indexPath) -> Void in
            currCell?.accessoryType = .none
            database.product.productArray[indexPath.row].checked = false
            database.save()
    })
    checkAction.backgroundColor=UIColor(red: 48.0/255, green: 173.0/255, blue: 99.0/255, alpha: 1.0)
    uncheckAction.backgroundColor=UIColor.red
    
    
        return isChecked ? [uncheckAction] : [checkAction]
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SearchBar metod
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked \(searchBar.text!)")
        database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
        DispatchQueue.main.async {
            self.searchedBar.resignFirstResponder()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("changed \(searchBar.text!)")
        database.filterData(searchText: searchBar.text!, searchTable: .products, searchField: (self.selectedSegmentIndex==0 ? .Product : .Producent))
    }
    
    // MARK: - My own methods
    func initSearchBar(_ searchBar: UISearchBar)
    {
        searchBar.placeholder=self.giveProductPrompt(with: true)[0]

        sg.removeAllSegments()
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[0], at: 0, animated: false)
        sg.insertSegment(withTitle: giveProductPrompt(with: false)[1], at: 1, animated: false)
        sg.selectedSegmentIndex = 0
        self.selectedSegmentIndex = 0
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
        self.selectedSegmentIndex = segment.selectedSegmentIndex
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goToAtHome"
        {
            let nextVC=segue.destination as! DetailAtHomeViewController
            nextVC.numberOfRow=numberOfRow
            
            nextVC.productImageName=database.product.productArray[numberOfRow].pictureName ?? "question-mark"
            nextVC.productTitle=database.product.productArray[numberOfRow].productName ?? "no product"
            nextVC.productSubtitle=database.product.productArray[numberOfRow].producent ?? "no producent"
            nextVC.productWeight="\(database.product.productArray[numberOfRow].weight)g"
        }
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
