//
//  CLTimer.swift
//  Pods
//
//  Created by apple on 05/07/16.
//
//

import UIKit

@objc public protocol CLTimerDelegate {
    @objc optional func timerDidUpdate(_ time:Int)
    @objc optional func timerDidStop(_ time:Int)
}

public class CLTimer: UIView {
    
    public enum TimeFormat{
        case minutes
        case seconds
    }
    
    public enum TimerMode{
        case reverse
        case forward
    }
    
    public weak var delegate : CLTimerDelegate?
    public var showDefaultCountDown = true {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var text = NSMutableAttributedString()
    var countDownFormat: TimeFormat = .seconds
    var timeModeForward: TimerMode = .forward
    var countDownFontSize = CGFloat()
    var schedular = Timer()
    var countDownSchedular = Timer()
    var timerSeconds = Int()
    var remainingTime = 0
    var countdownScalar = 0
    var countdownSmoother = 0.01
    var coveredTime:Double = 0
    var isRunning = false
    
    @IBInspectable
    var timerBackgroundColor : UIColor = .lightGray {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var countDownColor : UIColor = .green {
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
    
    public override func draw(_ rect: CGRect) {
        
        let timer = pathForTimer(timerCenter, radius: timerRadius)
        
        UIColor.clear.setFill()
        self.timerBackgroundColor.setStroke()
        timer.fill()
        timer.stroke()
        
        let countDown = pathForCountdown(timerCenter, radius: timerRadius)
        UIColor.clear.setFill()
        countDownColor.setStroke()
        countDown.fill()
        countDown.stroke()
        
        if self.showDefaultCountDown{
            if self.self.countDownFormat == .seconds{
                text = NSMutableAttributedString(string: "\(self.self.remainingTime)"+"s")
                self.countDownFontSize   =   (self.timerRadius/CGFloat(text.length)) * 2
            }else {
                let currentTime = secondsToMinutes(self.remainingTime)
                text = NSMutableAttributedString(string: "\(currentTime.min)"+":"+"\(currentTime.sec)")
                self.countDownFontSize = (self.timerRadius/CGFloat(text.length)) * 2.5
            }
            text.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: countDownFontSize), range: NSMakeRange(0, text.length))
            text.addAttribute(NSAttributedStringKey.foregroundColor,value: countDownColor, range: NSMakeRange(0, text.length))
            text.draw(at: CGPoint(x: timerCenter.x-text.size().width/2,y: timerCenter.y-text.size().height/2))
            
        }
    }
    
    func secondsToMinutes(_ timeToConvert:Int)->(min:Int,sec:Int){
        return (timeToConvert/60,timeToConvert%60)
    }
    
    private func pathForTimer(_ centerPoint:CGPoint,radius:CGFloat)->UIBezierPath{
        let path = UIBezierPath(arcCenter:centerPoint ,
                                radius: radius,
                                startAngle: 0.0,
                                endAngle: CGFloat(2*Double.pi),
                                clockwise: false)
        path.lineWidth = 2.0
        return path
        
    }
    
    private func pathForCountdown(_ centerPoint:CGPoint,radius:CGFloat)->UIBezierPath{
        var startAngle = CGFloat()
        var endAngle = CGFloat()
        
        if self.timeModeForward == .forward{
            if self.coveredTime <= 0.0{
                self.coveredTime = 0.0
            }
            endAngle = CGFloat((2*Double.pi)/Double(self.timerSeconds))*CGFloat(self.coveredTime)
            startAngle = CGFloat((3*Double.pi)/Double(2.0))
            
            let path = UIBezierPath(arcCenter:centerPoint ,radius: radius,startAngle: startAngle,endAngle: startAngle+endAngle,clockwise: true)
            path.lineWidth = 6.0
            return path
            
        }else{
            startAngle = CGFloat((2*Double.pi)/Double(self.timerSeconds))*CGFloat(self.coveredTime)
            endAngle = CGFloat((3*Double.pi)/Double(2.0))
            
            let path = UIBezierPath(arcCenter:centerPoint ,radius: radius,startAngle: startAngle+endAngle,endAngle: endAngle,clockwise: false)
            path.lineWidth = 6.0
            return path
        }
    }
    
    public  func startTimer(withSeconds seconds:Int,format: TimeFormat, mode:TimerMode){
        resetVariables()
        self.timerSeconds = seconds
        self.countDownFormat = format
        self.timeModeForward = mode
        
        if mode == .reverse{
            self.remainingTime = seconds
            self.coveredTime =  Double(seconds)
        }
        
        self.schedular = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        self.countDownSchedular = Timer.scheduledTimer(timeInterval: self.countdownSmoother, target: self, selector: #selector(self.updateCountDownTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if self.timeModeForward == .forward{
            self.remainingTime = self.remainingTime + 1
            
            if self.remainingTime == self.timerSeconds {
                schedular.invalidate()
            }
        }else{
            self.remainingTime = self.remainingTime - 1
            if self.remainingTime ==  0    {
                schedular.invalidate()
            }
        }
        self.delegate?.timerDidUpdate!(self.remainingTime)
        setNeedsDisplay()
    }
    
    public func resetTimer(){
        self.countDownSchedular.invalidate()
        self.schedular.invalidate()
        self.remainingTime = 0
        self.schedular = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CLTimer.setToStart), userInfo: nil, repeats: true)
    }
    
    public  func stopTimer(){
        self.delegate?.timerDidStop!(self.remainingTime)
        self.countDownSchedular.invalidate()
        self.schedular.invalidate()
    }
    
    @objc func setToStart(){
        if self.timeModeForward == .forward{
            self.coveredTime = self.coveredTime - self.coveredTime*100
            if self.coveredTime <= 0.0{
                print("ccc",self.coveredTime)
                self.schedular.invalidate()
                setNeedsDisplay()
            }else{
                setNeedsDisplay()
            }
            
        }else{
            self.coveredTime = self.coveredTime + (Double(self.timerSeconds)-self.coveredTime)*10
            if self.coveredTime >= Double(self.timerSeconds){
                self.schedular.invalidate()
                setNeedsDisplay()
            }else{
                setNeedsDisplay()
            }
        }
    }
    
    @objc func updateCountDownTimer(){
        if self.timeModeForward == .forward{
            self.coveredTime = self.coveredTime + self.countdownSmoother
            if self.coveredTime >= Double(self.timerSeconds){
                self.countDownSchedular.invalidate()
            }else{
                setNeedsDisplay()
            }
        }else{
            self.coveredTime = self.coveredTime - self.countdownSmoother
            if self.coveredTime  <= 0 {
                self.countDownSchedular.invalidate()
            }else{
                setNeedsDisplay()
            }
        }
    }
    
    func resetVariables(){
        self.countDownFormat = .seconds
        self.remainingTime = 0
        self.countdownScalar = 0
        self.countdownSmoother = 0.01
        self.coveredTime = 0
        self.countDownSchedular.invalidate()
        self.schedular.invalidate()
    }
}

