//
//  ToShopTableViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 20/11/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class ToShopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tabView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        database.loadData(tableNameType: .toShop)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        database.loadData(tableNameType: .toShop)
        tabView.reloadData()
        print("viewWillAppear")
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return database.toShopProductArray.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! ToShopTableViewCell
        //let toShop=ToShopProductTable(context: database.context)
        let toShop=database.toShopProductArray[indexPath.row].productRelation
        cell.producentLabel.text = toShop?.producent
        cell.productNameLabel.text = toShop?.productName
        let grams="\(toShop?.weight ?? 0)g"
        cell.detailLabel.text = grams.count==2 ? "" : grams
        if let img=toShop?.fullPicture {
            cell.picture.image = UIImage(data: img)
        }
        else {
            cell.picture.image = UIImage(named: "question-mark")
        }
        
        return cell
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let checkAction=UITableViewRowAction(style: .default, title: "🛍\nKup") { (action, indexPath) in
//        }
//        let uncheckAction=UITableViewRowAction(style: .default, title: "🗑\nZwróć") { (action, indexPath) in
//        }
//        checkAction.backgroundColor=UIColor.green
//        uncheckAction.backgroundColor=UIColor.red
//        return [checkAction,uncheckAction]
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             tableView.deleteRows(at: [indexPath], with: .fade)
            database.toShopProductArray.remove(at: 0)
            tableView.reloadData()
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    //     func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    //    }
    


    // Override to support conditional rearranging of the table view.
    //     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
    //        return true
    //    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
