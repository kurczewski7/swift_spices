//
//  AtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 24.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit


class AtHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rowNumber: Int  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK - tableView function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.imageView?.image=UIImage(named: picturesArray[indexPath.row])
        cell.textLabel?.text = picturesArray[indexPath.row]
        cell.detailTextLabel?.text="AAA\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowNumber = indexPath.row
        performSegue(withIdentifier: "goToAtHome", sender: self)
        //let mySegue = UIStoryboardSegue(identifier: "goToAtHome", source: self, destination: DetailAtHomeViewController)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToAtHome" {
                if let nextViewControler  =  segue.destination as? DetailAtHomeViewController {
                    nextViewControler.productTitle = "AAAAA"
                    nextViewControler.productSubtitle = picturesArray[rowNumber]
                    nextViewControler.productImageName = picturesArray[rowNumber]
                    print("Segue")
                }
            }
    }
}


