Pod::Spec.new do |s|
  s.name         = "GCAccessAuthorityView"
  s.version      = "0.0.1"
  s.summary      = "check system authority"
  s.description  = <<-DESC
                    check system authority show authority view...
                   DESC
  s.homepage     = "https://github.com/2563928639/GCAccessAuthorityView.git"
  s.license      = "MIT"
  s.author       = { "sunflower" => "2563928639@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/2563928639/GCAccessAuthorityView.git", :tag => "0.0.1"}
  s.source_files = "GCAccessAuthorityView/GCAccessAuthorityView/GCAccessAuthorityView/*.{h,m}"
  s.frameworks   = "UIKit","Foundation"

end