#
# Be sure to run `pod lib lint RatingsControllerNew.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RatingsControllerNew'
  s.version          = '0.1.3'
  s.summary          = 'Allows user to Rate/Review app on AppStore using RatingsControllerNew.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'PDRatingsController is singleton class allows user to rate app after user uses app n number of times as specified. Steps - 1. import PDRatingsController
2. Use following method where you want to initiate rating/review process.
3. [PDRatingsController ratingsWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count onViewController:(UIViewController*)_viewController];
4. Rest will taken care of by this class.'
  s.homepage         = 'https://github.com/parag-deshpande/RatingsControllerNew'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'parag-deshpande' => 'parag.deshpande@klouddata.com' }
  s.source           = { :git => 'https://github.com/parag-deshpande/RatingsControllerNew.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RatingsControllerNew/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RatingsControllerNew' => ['RatingsControllerNew/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
