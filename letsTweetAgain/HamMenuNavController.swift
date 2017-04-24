//
//  HamMenuNavController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/23/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class HamMenuNavController: UINavigationController {

    let TAG = "HamMenuNavController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLongPress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addLongPress() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.showUserAccountView(sender:)))
        
        longPressGestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        navigationBar.addGestureRecognizer(longPressGestureRecognizer)
        navigationBar.isUserInteractionEnabled = true
    }
    
    func showUserAccountView(sender: UILongPressGestureRecognizer) {
        print("\(TAG) - Open user accoung on long press")
        if sender.state == .began {
            performSegue(withIdentifier: "HamburgerAccountSegue", sender: nil)
        }
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
