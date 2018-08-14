//
//  AtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AtHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var numberOfRow=0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK - TableView metod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AtHomeCell

        cell.categoryLabel.text = "Przyprawa"
        cell.producentLabel.text="Winiary"
        cell.descriptionLabel.text = picturesArray[indexPath.row]
        cell.productPicture.image = UIImage(named: picturesArray[indexPath.row])
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
            nextVC.productImageName=picturesArray[numberOfRow]
            nextVC.productTitle="Przyprawa aaa"
            nextVC.productSubtitle="Knor"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
