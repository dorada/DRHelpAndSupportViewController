#
# Be sure to run `pod lib lint DRHelpAndSupportViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DRHelpAndSupportViewController"
  s.version          = "0.1.0"
  s.summary          = "Provides a toolkit to create a view controller with help and support options"
  s.description      = "Provides a toolkit to create a view controller with help and support options."

  s.homepage         = "https://github.com/dorada/DRHelpAndSupportViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel Broad" => "daniel@dorada.org" }
  s.source           = { :git => "https://github.com/dorada/DRHelpAndSupportViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DRHelpAndSupportViewController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ZipArchive', '~> 1.3.0'
  s.dependency 'DoradaCore', '~> 0.1.0'
end
