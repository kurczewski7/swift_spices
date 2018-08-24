//
//  Contacts.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 24.08.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class Contacts: UIViewController {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func callAction(_ sender: Any) {
        var tel = "512 58 95 28"
        tel=tel.replacingOccurrences(of: " ", with: "")
        print(tel)
        openMyUrl(with: "tel://\(tel)")
     }
    
    @IBAction func emailAction(_ sender: UIButton) {
        let email="kurczewski7@gmail.com"
        print(email)
        openMyUrl(with: "mailto://\(email)")
    }
    @IBAction func smsButton(_ sender: Any) {
        let sms=512589528
        print(sms)
        openMyUrl(with: "sms://\(sms)")
    }
    @IBAction func contactsActions(_ sender: Any) {
    }
    private func openMyUrl(with myStringUrl: String)
    {
        guard let url=URL(string: myStringUrl)    else {
                return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
