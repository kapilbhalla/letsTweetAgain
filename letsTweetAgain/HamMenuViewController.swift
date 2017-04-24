//
//  HamMenuViewController.swift
//  letsTweetAgain
//
//  Created by Bhalla, Kapil on 4/23/17.
//  Copyright © 2017 Bhalla, Kapil. All rights reserved.
//

import UIKit

class HamMenuViewController: UIViewController {

    let TAG = "HamMenuViewController"
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewLeftMarginConstraint: NSLayoutConstraint!
    
    var contentViewOriginalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()   //  this is a short cut to initialize the view lazily
            menuView.addSubview(menuViewController.view)
        }
    }

    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                // adding calls for the lifecycle methods
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            // the following statement will call ViewWillAppear
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.5) {
                self.contentViewLeftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print ("\(TAG) viewDidLoad")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        let FIXED_MARGIN: CGFloat = 150
        
        if sender.state == .began {
            contentViewOriginalLeftMargin = contentViewLeftMarginConstraint.constant
        } else if sender.state == .changed {
            contentViewLeftMarginConstraint.constant = contentViewOriginalLeftMargin + translation.x
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.4, animations: {
                if velocity.x > 0 {
                    self.contentViewLeftMarginConstraint.constant = self.view.frame .width - FIXED_MARGIN
                } else {
                    self.contentViewLeftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
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
