#
# Be sure to run `pod lib lint RatingsControllerNew.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RatingsControllerNew'
  s.version          = '0.2.1'
  s.summary          = 'Allows user to Rate/Review app on AppStore using RatingsControllerNew.'


s.description      = 'PDRatingsController is singleton class allows user to rate app after user uses app n number of times as specified.
    Steps -
    1. import PDRatingsView
    2. Use following method where you want to initiate rating/review process.
-- [[PDRatingsView ratings]initialiseWithAppId:@"12345" appName:@"abc" countAppUsed:2 remindAfter:0.5];
    3. Call on Button tap /action event / where user want to display rate promts
      -- [[PDRatingsView ratings] checkCountForAppUsedAndDisplayAlertOn:self];'


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
