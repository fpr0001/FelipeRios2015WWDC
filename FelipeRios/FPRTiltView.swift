//
//  FPRTiltView.swift
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 17/04/15.
//  Copyright (c) 2014 Sameh Mabrouk
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit
import CoreMotion

class TiltView: UIView {
    
    let CRMotionViewRotationMinimumThreshold:CGFloat = 0.1
    let CRMotionGyroUpdateInterval:NSTimeInterval = 1 / 100
    let CRMotionViewRotationFactor:CGFloat = 4.0
    private var motionManager: CMMotionManager = CMMotionManager()
    private var motionEnabled: Bool = true
    private var scrollIndicatorEnabled: Bool = true
    private var viewFrame: CGRect!
    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    private var motionRate:CGFloat!
    private var minimumXOffset:CGFloat!
    private var maximumXOffset:CGFloat!
    private var image: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), CGRectGetHeight(frame))
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("error 238hdib4c")
    }
    
    func commonInit(){
        
        
        //configuring scroll view
        self.scrollView = UIScrollView(frame: self.viewFrame)
        self.scrollView.userInteractionEnabled = false
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.contentSize = CGSizeZero
        self.addSubview(self.scrollView)
        
        self.imageView = UIImageView(frame: self.viewFrame)
        self.imageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.imageView.backgroundColor = UIColor.blackColor()
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.scrollView.addSubview(self.imageView)
        
        self.minimumXOffset = 0
        self.scrollIndicatorEnabled = true
        self.startMonitoring()
        
    }
    
    func setImage(image:UIImage){
        
        self.image = image
        
        let width = self.viewFrame.size.height / self.image.size.height * self.image.size.width
        self.imageView.frame = CGRectMake(0, 0, width, self.viewFrame.height)
        self.imageView.backgroundColor = UIColor.blueColor()
        self.imageView.image = self.image
        
        self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.scrollView.frame.size.height)
        self.scrollView.contentOffset = CGPointMake((self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2, 0)
        
        self.scrollView.enablePanoramaIndicator()
        self.motionRate = self.image.size.width / self.viewFrame.size.width * CRMotionViewRotationFactor
        self.maximumXOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width
    }
    
    func setMotionEnabled(motionEnabled:Bool){
        
        self.motionEnabled = motionEnabled
        if self.motionEnabled{
            
            self.startMonitoring()
        }
        else{
            
            self.stopMonitoring()
        }
    }
    
    func setScrollIndicatorEnabled(scrollIndicatorEnabled:Bool){
        
        self.scrollIndicatorEnabled = scrollIndicatorEnabled
        if self.scrollIndicatorEnabled{
            self.scrollView.enablePanoramaIndicator()
        }
        else{
            self.scrollView.disablePanoramaIndicator()
        }
        
    }

    func startMonitoring(){
        
        self.motionManager.gyroUpdateInterval = CRMotionGyroUpdateInterval
        if !self.motionManager.gyroActive && self.motionManager.gyroAvailable{
            
            self.motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (gyroData:CMGyroData!, error:NSError!) -> Void in
                
                self.rotateAccordingToDeviceMotionRotationRate(gyroData)
            })
        }
        else{
            println("There is no gyroscope. Error sa78hd3")
        }
    }
    

    func rotateAccordingToDeviceMotionRotationRate(gyroData:CMGyroData){

        let rotationRate = CGFloat(gyroData.rotationRate.y)
        if abs(rotationRate) >= CRMotionViewRotationMinimumThreshold{
            
            var offsetX = self.scrollView.contentOffset.x - rotationRate * self.motionRate
            if offsetX > self.maximumXOffset{
                
                offsetX = self.maximumXOffset
            }
            else if offsetX < self.minimumXOffset{
                
                offsetX = self.minimumXOffset
            }

            UIView.animateWithDuration(0.3, delay: 0.0, options: .BeginFromCurrentState | .AllowUserInteraction | .CurveEaseOut, animations: { () -> Void in
                self.scrollView.setContentOffset(CGPointMake(offsetX, 0), animated: false)
                }, completion: nil)
        }
    }

    func stopMonitoring(){
        self.motionManager.stopGyroUpdates()
    }
    
}