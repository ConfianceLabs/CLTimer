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

Step 1 - Replace UIView class with CLTimer in your xib or StoryBoard.  

Step 2 - Create its Outlet.  

```swift
  @IBOutlet weak var timer: CLTimer!
```

To start Timer

```swift
  timer.startTimer(withSeconds: 100, format:.Minutes , mode: .Reverse)
```



To Reset Timer

```swift
  timer.resetTimer()
```

## Add Ons 

You can choose time format :- .Minutes/ .Seconds  
You can also choose CountDown Mode :- .Forward/.Reverse
You can hide the default countDown Time and show countDown time on Your own Label using 
CLTimer's Delegate function first of all apply cltimerDelegate

```swift
  class ViewController: UIViewController,cltimerDelegate
```
Then hide default countDown   

```swift
  timer.showDefaultCountDown=false
```
Finally use delegate function to get countDown time  

```swift
 func timerDidUpdate(time:Int){
        print("updated Time : ",time)
        myLabel.text  = "\(time) Seconds"
        }
```

## Author

Dewanshu Sharma, sdivyanshu23@gmail.com

## License

CLTimer is available under the MIT license. See the LICENSE file for more info.
