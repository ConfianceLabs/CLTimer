#
# Be sure to run `pod lib lint CLTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CLTimer'
  s.version          = '0.1.3'
  s.summary          = 'A Circular Timer in swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'CLTimer provides you a circular timer to integrate in your ios app with multiple designs and time format options. Intead of writing complicated code with complex calculations you can simply integrate Timer in your app with 4-5 lines of code'


  s.homepage         = 'https://github.com/ConfianceLabs/CLTimer.git'
  # s.screenshots     = 'https://www.dropbox.com/s/uoeg6en2zqz4zgg/Simulator%20Screen%20Shot%2006-Jul-2016%2C%203.54.19%20AM.png?dl=0', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dewanshu Sharma' => 'sdivyanshu23@gmail.com' }
  s.source           = { :git => 'https://github.com/ConfianceLabs/CLTimer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CLTimer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CLTimer' => ['CLTimer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
