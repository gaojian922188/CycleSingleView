#
# Be sure to run `pod lib lint CycleSingleView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CycleSingleView'
  s.version          = '0.1.0'
  s.summary          = '无限向上滚动的view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
无限向上滚动的view，最少两条数据，一条数据不滚动
                       DESC

  s.homepage         = 'http://git.innotechx.com/scm/md/cyclesingleview.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tree' => 'tanlusheng@innotechx.com' }
  s.source           = { :git => 'http://tanlusheng@git.innotechx.com/scm/md/cyclesingleview.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CycleSingleView/Classes/**/*.swift'
  
  s.resource_bundles = {
    'CycleSingleView' => ['CycleSingleView/Assets/*.xib']
  }
  s.swift_version = '4.0'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
