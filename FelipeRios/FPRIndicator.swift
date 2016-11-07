//
//  FPRIndicator.swift
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 17/04/15.
//  Copyright (c) 2014 Sameh Mabrouk
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import UIKit

let ScrollIndicatorLeftRightThreshold:CGFloat = 16.0
let ScrollIndicatorBottomSpace:CGFloat = 20.0
let ScrollIndicatorHeight:CGFloat = 1.0
let ScrollIndicatorDefaultWidth:CGFloat = 20.0
var viewScrollIndicatorKey: Void?
var backgroundViewScrollIndicatorKey: Void?

extension UIScrollView{
    
    func setViewForPanoramaIndicator(_ viewScrollIndicator:UIView){
        objc_setAssociatedObject(self, &viewScrollIndicatorKey, viewScrollIndicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func getViewForPanoramaIndicator() -> UIView?{
        
        return objc_getAssociatedObject(self, &viewScrollIndicatorKey) as? UIView;
    }
    func setBackgroundViewForPanoramaIndicator(_ backgroundViewScrollIndicator:UIView){
        
        objc_setAssociatedObject(self, &backgroundViewScrollIndicatorKey, backgroundViewScrollIndicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    func getBackgroundViewForPanoramaIndicator()-> UIView?{
        return objc_getAssociatedObject(self, &backgroundViewScrollIndicatorKey) as? UIView;
    }
    
    func enablePanoramaIndicator(){
        
        if self.getBackgroundViewForPanoramaIndicator() == nil && self.getViewForPanoramaIndicator() == nil{
            
            self.showsHorizontalScrollIndicator = false
            let indicatorColor:UIColor = UIColor.white
            
            let backgroundIndicatorWidth:CGFloat = self.frame.size.width - (ScrollIndicatorLeftRightThreshold * 2)
            let backgroundIndicatorFrame:CGRect = CGRect(x: self.contentOffset.x + (self.frame.size.width / 2) - (backgroundIndicatorWidth / 2), y: self.frame.size.height - ScrollIndicatorHeight - ScrollIndicatorBottomSpace, width: backgroundIndicatorWidth, height: ScrollIndicatorHeight)
            
            var backgroundViewScrollIndicator:UIView!
            backgroundViewScrollIndicator = UIView(frame: backgroundIndicatorFrame)
            backgroundViewScrollIndicator.backgroundColor = indicatorColor.withAlphaComponent(0.50)
            self.setBackgroundViewForPanoramaIndicator(backgroundViewScrollIndicator)
            self.addSubview(backgroundViewScrollIndicator)
            
            var viewScrollIndicatorWidth:CGFloat = (self.bounds.size.width - (ScrollIndicatorLeftRightThreshold * 2)) * (self.bounds.size.width - (ScrollIndicatorLeftRightThreshold * 2)) / self.contentSize.width
            if viewScrollIndicatorWidth < ScrollIndicatorDefaultWidth{
                
                viewScrollIndicatorWidth = ScrollIndicatorDefaultWidth
            }
            
            let scrollIndicatorFrame:CGRect = CGRect(x: self.contentOffset.x + (self.frame.size.width / 2) - (viewScrollIndicatorWidth / 2), y: self.frame.size.height - ScrollIndicatorHeight - ScrollIndicatorBottomSpace, width: viewScrollIndicatorWidth, height: ScrollIndicatorHeight)
            
            var viewScrollIndicator:UIView!
            viewScrollIndicator = UIView(frame: scrollIndicatorFrame)
            viewScrollIndicator.backgroundColor = indicatorColor.withAlphaComponent(1.0)
            [self .setViewForPanoramaIndicator(viewScrollIndicator)];
            self.addSubview(viewScrollIndicator)
            
            self.setupObservers()
        }
    }
    
    func refreshPanoramaIndicator(){
        self.refreshBackgroundPanoramaIndicator()
        self.refreshPanoramaViewIndicator()
    }
    
    func refreshBackgroundPanoramaIndicator(){
        
        let backgroundViewScrollIndicator:UIView = self.getBackgroundViewForPanoramaIndicator()!
        let x:CGFloat = self.contentOffset.x + ScrollIndicatorLeftRightThreshold
        let rect:CGRect = CGRect(x: x, y: backgroundViewScrollIndicator.frame.origin.y, width: backgroundViewScrollIndicator.frame.width, height: backgroundViewScrollIndicator.frame.height)
        backgroundViewScrollIndicator.frame = rect
    }
    
    func refreshPanoramaViewIndicator(){
        
        let viewScrollIndicator:UIView = self.getViewForPanoramaIndicator()!
        let percent:CGFloat = self.contentOffset.x / self.contentSize.width
        let x:CGFloat =  self.contentOffset.x + ((self.bounds.size.width - ScrollIndicatorLeftRightThreshold) * percent) + ScrollIndicatorLeftRightThreshold
        let rect:CGRect = CGRect(x: x, y: viewScrollIndicator.frame.origin.y, width: viewScrollIndicator.frame.width, height: viewScrollIndicator.frame.height)
        viewScrollIndicator.frame = rect
    }
    
    func disablePanoramaIndicator(){
        print("Disabeling panorama indicator")
        self.stopObservers()
        self.getBackgroundViewForPanoramaIndicator()?.removeFromSuperview()
        self.getViewForPanoramaIndicator()?.removeFromSuperview()
    }
    
    //observers
    
    func setupObservers(){
        self.addObserver(self, forKeyPath:"contentSize", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old] , context: nil)
        self.addObserver(self, forKeyPath:"contentOffset", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old] , context: nil)
    }
    
    func stopObservers(){
        self.removeObserver(self, forKeyPath: "contentSize")
        self.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.contentSize.width > 0.0{
            self.refreshPanoramaIndicator()
        }
    }
}
