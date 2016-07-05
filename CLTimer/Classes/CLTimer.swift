//
//  CLTimer.swift
//  Pods
//
//  Created by apple on 05/07/16.
//
//

import UIKit

protocol cltimerDelegate {
    func timerDidUpdate(time:Int)
    func timerDidStop(time:Int)
}


public class CLTimer: UIView {
    
    
   public enum timeFormat{
        case Minutes
        case Seconds
    }

   public enum timerMode{
        case Reverse
        case Forward
    }
    
    var cltimer_delegate :   cltimerDelegate?
    var text    =   NSMutableAttributedString()
    var countDownFormat =   0
    var countDownFontSize   =   CGFloat()
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
    
    
    
    
    
    
    
    override public func drawRect(rect: CGRect) {
        
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
        
        
       
        if countDownFormat==0{
             text = NSMutableAttributedString(string: "\(remainingTime)"+"s")
             countDownFontSize   =   (timerRadius/CGFloat(text.length)) * 2
        }else if countDownFormat==1{
             let currentTime = secondsToMinutes(remainingTime)
            text = NSMutableAttributedString(string: "\(currentTime.min)"+":"+"\(currentTime.sec)")
            countDownFontSize   =   (timerRadius/CGFloat(text.length)) * 2.5
        }
       
        
        
        text.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(countDownFontSize), range: NSMakeRange(0, text.length))
        text.addAttribute(NSForegroundColorAttributeName,value: countDownColor, range: NSMakeRange(0, text.length))
        text.drawAtPoint(CGPoint(x: timerCenter.x-text.size().width/2,y: timerCenter.y-text.size().height/2))

        
    }
    
    func secondsToMinutes(timeToConvert:Int)->(min:Int,sec:Int){
        return (timeToConvert/60,timeToConvert%60)
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
            path.lineWidth  =   6.0
            return path
            
        }else{
            startAngle   =   CGFloat((2*M_PI)/Double(timerSeconds))*CGFloat(coveredTime)
            endAngle  =   CGFloat((3*M_PI)/Double(2.0))
            
            let path    =   UIBezierPath(arcCenter:centerPoint ,radius: radius,startAngle: startAngle+endAngle,endAngle: endAngle,clockwise: false)
            path.lineWidth  =   6.0
            return path
        }
        
    }
    
    

    
  public  func startTimer(withSeconds seconds:Int,format:timeFormat,mode:timerMode){
        
        timerSeconds    =   seconds
    
    
    switch format{
    case .Seconds:
        countDownFormat=0
    case .Minutes:
        countDownFormat=1
    }
    
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
            
            if remainingTime ==  0    {
                schedular.invalidate()
                
            }
        }
        
        
       setNeedsDisplay()
        

    }
    
  public   func resetTimer(){
        countDownSchedular.invalidate()
        schedular.invalidate()
        remainingTime=0
        schedular  =  NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(CLTimer.setToStart), userInfo: nil, repeats: true)
        
    }
   
  public  func stopTimer(){
        countDownSchedular.invalidate()
        schedular.invalidate()
    }
    
    func setToStart(){
        
        if timeModeForward{
            coveredTime =   coveredTime -  countdownSmoother*50
            if coveredTime  <= 0.0{
                print("ccc",coveredTime)
                schedular.invalidate()
                 //setNeedsDisplay()
            }else{
                setNeedsDisplay()
            }
            
        }else{
            coveredTime =   coveredTime +  countdownSmoother*50
            
            if coveredTime  >= Double(timerSeconds){
                schedular.invalidate()
                setNeedsDisplay()
            }else{
                setNeedsDisplay()
            }
            
            
        }
        
       
       
        
    }
    
    
    func updateCountDownTimer(){
       
        if timeModeForward{
            coveredTime =   coveredTime +   countdownSmoother
            if coveredTime >= Double(timerSeconds){
                countDownSchedular.invalidate()
            }else{
                setNeedsDisplay()
            }
            
            
        }else{
            coveredTime =   coveredTime -   countdownSmoother
            if coveredTime  <= 0 {
                countDownSchedular.invalidate()
            }else{
              setNeedsDisplay()  
            }
        }
        
    }
    
    
    
}
