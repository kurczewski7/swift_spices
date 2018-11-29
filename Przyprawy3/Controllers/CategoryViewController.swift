//
//  CategoryViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 14/11/2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.category.categoryArray.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cellCategories", for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor=UIColor.lightGray
        cell.layer.cornerRadius=20
        cell.contentLabel.text=database.category.categoryArray[indexPath.row].pictureEmoji
        //categoryArray[indexPath.row].pictureEmoji                 //"🌶🧂 🍏🍒🍐🥬🥕🥒"
        cell.nameLabel.textColor=(database.category.categoryArray[indexPath.row].selectedCategory ? UIColor.blue:  UIColor.black)
        cell.likeButton.isEnabled = (database.category.categoryArray[indexPath.row].selectedCategory ? true : false)
        cell.nameLabel.text=database.category.categoryArray[indexPath.row].categoryName
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("wybrano kategorię \(indexPath.row)")
        database.selectedCategory=database.findSelestedCategory(categoryId : indexPath.row)
        performSegue(withIdentifier: "goToProducts", sender: self)
        //performSegue(withIdentifier: "goToAtHome", sender: self)
    }
    //database.categoryArray[indexPath.row].categoryName

    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShopingListCellView
    //
    //        // Configure the cell
    //        cell.backgroundView?.backgroundColor = UIColor.brown
    //        cell.productName.text = "aaa"
    //        cell.productPicture.image = UIImage(named: picturesArray[indexPath.row])


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
