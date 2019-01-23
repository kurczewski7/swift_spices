//
//  InBasketViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 18/01/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

class InBasketViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // categoryId   productName
        
        
        let context = database.context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductTable")
        
        let letterSort = NSSortDescriptor(key: "categoryId", ascending: true)
        let letterSort2=NSSortDescriptor(key: "productName", ascending: true)
        fetchRequest.sortDescriptors = [letterSort,letterSort2]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: "categoryId",
                                                              cacheName: "SectionCache")
        
        fetchedResultsController.delegate =  self           // self as! NSFetchedResultsControllerDelegate
            //as! NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    func numberOfSectionsInTableView
        (tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let sectionInfo =
            fetchedResultsController.sections![section]
        return sectionInfo.name
    }
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let sectionInfo =
            fetchedResultsController.sections![section]
        print(sectionInfo.numberOfObjects)
        return sectionInfo.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InBasketTableViewCell
        let tmp = database.product.productArray[indexPath.row]
        cell.producentLabel.text="aaa\(indexPath.row)"
        return cell
    }
    func firstRunSetupSections(forEntityName entityName : String) {    
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
