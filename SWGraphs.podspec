#
# Be sure to run `pod lib lint SWGraphs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWGraphs'
  s.version          = '0.1.3'
  s.summary          = 'A Swift library for operations on graphs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A Swift library for operations on graphs. This description will be extended.
                       DESC

  s.homepage         = 'https://github.com/VihlayewAlex/SWGraphs'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'VihlayewAlex' => 'vihlayew.alex@gmail.com' }
  s.source           = { :git => 'https://github.com/VihlayewAlex/SWGraphs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    s.social_media_url = 'https://vk.com/vihlayew'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SWGraphs/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SWGraphs' => ['SWGraphs/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
