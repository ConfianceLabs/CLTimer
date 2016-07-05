//
//  CLTimer.swift
//  Pods
//
//  Created by apple on 05/07/16.
//
//

import UIKit

class CLTimer: UIView {
    
    
    enum timeFormat{
        case Minutes
        case Seconds
    }

    enum timerMode{
        case Reverse
        case Forward
    }
    
    var hello=String()
    var timeModeForward =   Bool()
    var schedular   =   NSTimer()
    var countDownSchedular   =   NSTimer()
    var timerSeconds    =   Int()
    var remainingTime   =   0
    var countdownScalar =   0
    var countdownSmoother   =   0.01
    var coveredTime:Double   =   0
    @IBInspectable
    var timerBackgroundColor  :    UIColor =   UIColor.lightGrayColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var countDownColor   :    UIColor =   UIColor.greenColor(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    var timerRadius :   CGFloat {
        return min(bounds.size.width,bounds.size.height)/2 * 0.80
    }
    
    var timerCenter :   CGPoint {
        return CGPoint(x: bounds.midX,y: bounds.midY)
    }
    
    
    
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        let timer   =   pathForTimer(timerCenter, radius: timerRadius)
        
        UIColor.clearColor().setFill()
        timerBackgroundColor.setStroke()
        timer.fill()
        timer.stroke()
        
        
        let countDown   =   pathForCountdown(timerCenter, radius: timerRadius)
        UIColor.clearColor().setFill()
        countDownColor.setStroke()
        countDown.fill()
        countDown.stroke()
        
        
    }
    
    
    private func pathForTimer(centerPoint:CGPoint,radius:CGFloat)->UIBezierPath{
       
        let path    =   UIBezierPath(arcCenter:centerPoint ,
                                     radius: radius,
                                     startAngle: 0.0,
                                     endAngle: CGFloat(2*M_PI),
                                     clockwise: false)
        
        
        
        path.lineWidth  =   2.0
        return path
        
    }
    
    private func pathForCountdown(centerPoint:CGPoint,radius:CGFloat)->UIBezierPath{
        
        var startAngle  =   CGFloat()
        var endAngle    =   CGFloat()
        
        if timeModeForward{
            endAngle   =   CGFloat((2*M_PI)/Double(timerSeconds))*CGFloat(coveredTime)
            startAngle  =   CGFloat((3*M_PI)/Double(2.0))
            
            let path    =   UIBezierPath(arcCenter:centerPoint ,radius: radius,startAngle: startAngle,endAngle: startAngle+endAngle,clockwise: true)
            path.lineWidth  =   4.0
            return path
            
        }else{
            startAngle   =   CGFloat((2*M_PI)/Double(timerSeconds))*CGFloat(coveredTime)
            endAngle  =   CGFloat((3*M_PI)/Double(2.0))
            
            let path    =   UIBezierPath(arcCenter:centerPoint ,radius: radius,startAngle: startAngle+endAngle,endAngle: endAngle,clockwise: false)
            path.lineWidth  =   4.0
            return path
        }
        
    }
    
    

    
    func startTimer(withSeconds seconds:Int,format:timeFormat,mode:timerMode){
        
        timerSeconds    =   seconds
        
        switch mode{
        case .Forward:
            timeModeForward =   true
        case .Reverse:
            remainingTime   =   seconds
            coveredTime =  Double(seconds)
            timeModeForward =   false
            }
        
        schedular  =  NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CLTimer.updateTimer), userInfo: nil, repeats: true)
        
        countDownSchedular =   NSTimer.scheduledTimerWithTimeInterval(countdownSmoother, target: self, selector: #selector(CLTimer.updateCountDownTimer), userInfo: nil, repeats: true)
        
        
    }
    
    
    func updateTimer(){
        
        if timeModeForward{
             remainingTime    =   remainingTime    +   1
            
            if remainingTime ==  timerSeconds    {
                schedular.invalidate()
                
            }
            
        }else{
             remainingTime    =   remainingTime    -   1
            
            if remainingTime ==  1    {
                schedular.invalidate()
                
            }
        }
        
        
       setNeedsDisplay()
        

    }
    
    func updateCountDownTimer(){
       
        if timeModeForward{
            coveredTime =   coveredTime +   countdownSmoother
        }else{
            coveredTime =   coveredTime -   countdownSmoother
        }
        setNeedsDisplay()
    }
    
    
    
}
