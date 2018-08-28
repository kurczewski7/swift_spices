//
//  PhoneContactsViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 28.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Contacts


class PhoneContactsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    var store:CNContactStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store=CNContactStore()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: TableView method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="\(indexPath.row)"
        cell.imageView?.image=UIImage(named: "user-male-icon")
        
        // Configure the cell...
        
        return cell
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    func getContacts()
    {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .authorized
        {
            self.readContacts(from : store!)
        }
        else if status == .notDetermined
        {
           store?.requestAccess(for: .contacts
            , completionHandler: { (autorized, error) in
                if(autorized)
                {
                    self.readContacts(from : self.store!)
                }
           })
        }
    }
    func readContacts(from store : CNContactStore) {
        do {
            let groups = try store.groups(matching: nil)
            //let predicate=CNContact.predicateForContacts(matchingName: "slawek")
            let predicate = CNContact.predicateForContacts(withIdentifiers: [groups[0].identifier])
            let keyToFetch: [CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey as CNKeyDescriptor]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keyToFetch)
            //self.object=
            //dispat_asynch
         
        }
        catch {
            
        }
        
    }
    
    
    
    
//    func retrieveContactsWithStore(store: CNContactStore) {
//        do {
//            let groups = try store.groupsMatchingPredicate(nil)
//            let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
//            //let predicate = CNContact.predicateForContactsMatchingName("John")
//            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey]
//
//            let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
//            self.objects = contacts
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.tableView.reloadData()
//            })
//        } catch {
//            print(error)
//        }
//    }
 
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
