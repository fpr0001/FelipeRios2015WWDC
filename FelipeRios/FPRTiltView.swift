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
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class TiltView: UIView {
    
    let CRMotionViewRotationMinimumThreshold:CGFloat = 0.1
    let CRMotionGyroUpdateInterval:TimeInterval = 1 / 100
    let CRMotionViewRotationFactor:CGFloat = 4.0
    fileprivate var motionManager: CMMotionManager = CMMotionManager()
    fileprivate var motionEnabled: Bool = true
    fileprivate var scrollIndicatorEnabled: Bool = true
    fileprivate var viewFrame: CGRect!
    fileprivate var scrollView: UIScrollView!
    fileprivate var imageView: UIImageView!
    fileprivate var motionRate:CGFloat!
    fileprivate var minimumXOffset:CGFloat!
    fileprivate var maximumXOffset:CGFloat!
    fileprivate var image: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error 238hdib4c")
    }
    
    func commonInit(){
        
        
        //configuring scroll view
        self.scrollView = UIScrollView(frame: self.viewFrame)
        self.scrollView.isUserInteractionEnabled = false
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.contentSize = CGSize.zero
        self.addSubview(self.scrollView)
        
        self.imageView = UIImageView(frame: self.viewFrame)
        self.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.imageView.backgroundColor = UIColor.black
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.scrollView.addSubview(self.imageView)
        
        self.minimumXOffset = 0
        self.scrollIndicatorEnabled = true
        self.startMonitoring()
        
    }
    
    func setImage(_ image:UIImage){
        
        self.image = image
        
        let width = self.viewFrame.size.height / self.image.size.height * self.image.size.width
        self.imageView.frame = CGRect(x: 0, y: 0, width: width, height: self.viewFrame.height)
        self.imageView.backgroundColor = UIColor.blue
        self.imageView.image = self.image
        
        self.scrollView.contentSize = CGSize(width: self.imageView.frame.size.width, height: self.scrollView.frame.size.height)
        self.scrollView.contentOffset = CGPoint(x: (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2, y: 0)
        
        self.scrollView.enablePanoramaIndicator()
        self.motionRate = self.image.size.width / self.viewFrame.size.width * CRMotionViewRotationFactor
        self.maximumXOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width
    }
    
    func setMotionEnabled(_ motionEnabled:Bool){
        
        self.motionEnabled = motionEnabled
        if self.motionEnabled{
            
            self.startMonitoring()
        }
        else{
            
            self.stopMonitoring()
        }
    }
    
    func setScrollIndicatorEnabled(_ scrollIndicatorEnabled:Bool){
        
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
        if !self.motionManager.isGyroActive && self.motionManager.isGyroAvailable{
            self.motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData, error) in
                self.rotateAccordingToDeviceMotionRotationRate(gyroData!)
            })
        }
        else{
            print("There is no gyroscope. Error sa78hd3")
        }
    }
    

    func rotateAccordingToDeviceMotionRotationRate(_ gyroData:CMGyroData){

        let rotationRate = CGFloat(gyroData.rotationRate.y)
        if abs(rotationRate) >= CRMotionViewRotationMinimumThreshold{
            
            var offsetX = self.scrollView.contentOffset.x - rotationRate * self.motionRate
            if offsetX > self.maximumXOffset{
                
                offsetX = self.maximumXOffset
            }
            else if offsetX < self.minimumXOffset{
                
                offsetX = self.minimumXOffset
            }

            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: { () -> Void in
                self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
                }, completion: nil)
        }
    }

    func stopMonitoring(){
        self.motionManager.stopGyroUpdates()
    }
    
}
