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
    @IBOutlet var productWeightLabel: UILabel!
    
    
    var productImageName = ""
    var productTitle = ""
    var productSubtitle = ""
    var productWeight = ""
    var numberOfRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImageView.image=UIImage(named: productImageName)
        productTitleLabel.text=productTitle
        productSubtitleLabel.text=productSubtitle
        productWeightLabel.text=productWeight
        if(is3Dtouch)
        {
            registerForPreviewing(with: self, sourceView: view)
        }
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
// MARK: 3D Touch dellegate method
extension DetailAtHomeViewController : UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
      let convertedLocation=view.convert(location, to: productImageView)
        if(productImageView.bounds.contains(convertedLocation)) {
            let popVC=storyboard?.instantiateViewController(withIdentifier: "popVC") as! popViewController
            popVC.popImage = productImageView.image!
            //Set your height
            popVC.preferredContentSize = CGSize(width: 0.0, height: 400)
            previewingContext.sourceRect = productImageView.frame
            return popVC
        }
        else {
          return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let viewController = viewControllerToCommit as? popViewController {
            viewController.back.isHidden=false
        }
        show(viewControllerToCommit, sender: self)
    }
}

