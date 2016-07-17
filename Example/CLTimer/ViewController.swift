//
//  ViewController.swift
//  CLTimer
//
//  Created by Dewanshu Sharma on 07/05/2016.
//  Copyright (c) 2016 Dewanshu Sharma. All rights reserved.
//

import UIKit
import CLTimer


class ViewController: UIViewController,cltimerDelegate {

 
    @IBOutlet weak var timer: CLTimer!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timer.cltimer_delegate=self
       // timer.showDefaultCountDown=false
    }

    @IBAction func stopTimer(sender: AnyObject) {
        timer.stopTimer()
    }
   
    @IBAction func resetTimer(sender: AnyObject) {
        timer.resetTimer()
       
    }
   
    @IBAction func startTimer(sender: AnyObject) {
        timer.startTimer(withSeconds: 3, format:.Minutes , mode: .Reverse)
    }
    
    
    func timerDidStop(time:Int){
         print("Stopped time : ",time)
    }
    
    func timerDidUpdate(time:Int){
        print("updated Time : ",time)
    }
}

