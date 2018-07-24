//
//  DetailAtHomeViewController.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 24.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class DetailAtHomeViewController: UIViewController {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productSubtitleLabel: UILabel!
    
    var productImageName = ""
    var productTitle = ""
    var productSubtitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImageView.image=UIImage(named: productImageName)
        productTitleLabel.text=productTitle
        productSubtitleLabel.text=productSubtitle

        // Do any additional setup after loading the view.
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

}
