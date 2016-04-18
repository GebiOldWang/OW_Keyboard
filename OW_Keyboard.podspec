Pod::Spec.new do |s|
  s.name         = "OW_Keyboard"
  s.version      = "0.0.2"
  s.summary      = "A keyboard for iphone"
  s.homepage     = "https://github.com/GebiOldWang/OW_Keyboard"
  s.license      = "MIT"
  s.platforms = { :ios => "7.0" }
  s.author             = { "GebiOldWang" => "840226514@qq.com" }
  s.source       = { :git => "https://github.com/GebiOldWang/OW_Keyboard.git", :tag => "0.0.2" }
  s.source_files  = "OW_Keyboard/**/*.{h,m}"
  s.framework  = "UIKit"

end