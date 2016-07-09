# CLTimer

[![CI Status](http://img.shields.io/travis/Dewanshu Sharma/CLTimer.svg?style=flat)](https://travis-ci.org/Dewanshu Sharma/CLTimer)
[![Version](https://img.shields.io/cocoapods/v/CLTimer.svg?style=flat)](http://cocoapods.org/pods/CLTimer)
[![License](https://img.shields.io/cocoapods/l/CLTimer.svg?style=flat)](http://cocoapods.org/pods/CLTimer)
[![Platform](https://img.shields.io/cocoapods/p/CLTimer.svg?style=flat)](http://cocoapods.org/pods/CLTimer)

![Alt text](https://s31.postimg.org/j92eliel7/Simulator_Screen_Shot_06_Jul_2016_3_54_19_AM.png "CLTimer beta")


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 2.2

## Installation

CLTimer provides you a circular timer to integrate in your ios app with multiple designs and time format options. Intead of writing complicated code with complex calculations you can simply integrate Timer in your app with a single line of code.

CLTimer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CLTimer"
```

Step 1 - From identity inspector replace UIView class of your UIView with CLTimer class in your xib or StoryBoard.  

Step 2 - Create its Outlet.  

```swift
  @IBOutlet weak var timer: CLTimer!
```

To start Timer

```swift
  timer.startTimer(withSeconds: 100, format:.Minutes , mode: .Reverse)
```

Change countDown circle and Timer circle color by selecting CLTimer View from your StoryBoard or xib.    


![Alt text](https://s26.postimg.org/tx6ovtreh/jhj.png )   


  



To Reset Timer

```swift
  timer.resetTimer()
```   



To Stop Timer  

```swift
  timer.stopTimer()
```   


To Hide Default CountDown  

```swift
  timer.showDefaultCountDown=false
```   


To Show CountDown time on your Own Label    


- Apply cltimerDelegate
```swift
  class ViewController: UIViewController,cltimerDelegate
```   


- use its Delegate Function  
 
```swift
 func timerDidUpdate(time:Int){
        print("updated Time : ",time)
        myLabel.text  = "\(time) Seconds"
     }
```      




You can also checkout some other CLTimer Delegate functions 


# YouTube Link   

https://www.youtube.com/channel/UCwYjZ3vXQYhJaRwUm6u9-bA

## Author

Dewanshu Sharma, sdivyanshu23@gmail.com

## License

CLTimer is available under the MIT license. See the LICENSE file for more info.
