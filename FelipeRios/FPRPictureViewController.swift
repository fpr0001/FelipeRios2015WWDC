//
//  FPRPictureViewController.swift
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 17/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//

import UIKit

let BUTTON_DONE_WIDTH:CGFloat = 80.0
let BUTTON_DONE_DISTANCE_FROM_SCREEN:CGFloat = 20.0

@objc open class FPRPictureViewController: UIViewController {

    @objc var image: UIImage!
    var buttonDone: UIButton!
    var motionView: TiltView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.slide)
        
        //show tilt view
        self.motionView = TiltView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: self.view.bounds.size.height+UIApplication.shared.statusBarFrame.size.height))
        self.motionView.setImage(image)
        self.view.addSubview(self.motionView)
        
        self.addButtonDone()
    }
    
    @objc func buttonDoneClicked(){
        self.motionView.setScrollIndicatorEnabled(false)
        self.dismiss(animated: true, completion: {
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.slide)
        })
    }
    
    fileprivate func addButtonDone(){
        self.buttonDone = UIButton(type: UIButton.ButtonType.custom)
        self.buttonDone.frame = CGRect(x: self.view.frame.size.width - BUTTON_DONE_WIDTH - BUTTON_DONE_DISTANCE_FROM_SCREEN, y: BUTTON_DONE_DISTANCE_FROM_SCREEN, width: BUTTON_DONE_WIDTH, height: 40.0)
        self.buttonDone.setTitle("Done", for: UIControl.State())
        self.buttonDone.setTitleColor(UIColor.white, for: UIControl.State())
        self.buttonDone.contentVerticalAlignment=UIControl.ContentVerticalAlignment.top
        self.buttonDone.contentHorizontalAlignment=UIControl.ContentHorizontalAlignment.right
        self.buttonDone.addTarget(self, action: #selector(FPRPictureViewController.buttonDoneClicked), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self.buttonDone)
        self.view.bringSubviewToFront(self.buttonDone)
    }
    
    
    //disable landscape mode
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    open override var shouldAutorotate : Bool {
        return false
    }
}
