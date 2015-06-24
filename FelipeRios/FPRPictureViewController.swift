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

@objc public class FPRPictureViewController: UIViewController {

    @objc var image: UIImage!
    var buttonDone: UIButton!
    var motionView: TiltView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Slide)
        
        //show tilt view
        self.motionView = TiltView(frame: CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height+UIApplication.sharedApplication().statusBarFrame.size.height))
        self.motionView.setImage(image)
        self.view.addSubview(self.motionView)
        
        self.addButtonDone()
    }
    
    func buttonDoneClicked(){
        self.motionView.setScrollIndicatorEnabled(false)
        self.dismissViewControllerAnimated(true, completion: {
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        })
    }
    
    private func addButtonDone(){
        self.buttonDone = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        self.buttonDone.frame = CGRectMake(self.view.frame.size.width - BUTTON_DONE_WIDTH - BUTTON_DONE_DISTANCE_FROM_SCREEN, BUTTON_DONE_DISTANCE_FROM_SCREEN, BUTTON_DONE_WIDTH, 40.0)
        self.buttonDone.setTitle("Done", forState: UIControlState.Normal)
        self.buttonDone.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.buttonDone.contentVerticalAlignment=UIControlContentVerticalAlignment.Top
        self.buttonDone.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Right
        self.buttonDone.addTarget(self, action: "buttonDoneClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.buttonDone)
        self.view.bringSubviewToFront(self.buttonDone)
    }
    
    
    //disable landscape mode
    override public func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    public override func shouldAutorotate() -> Bool {
        return false
    }
}
