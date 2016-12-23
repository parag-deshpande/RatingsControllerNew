# RatingsControllerNew

[![CI Status](http://img.shields.io/travis/parag-deshpande/RatingsControllerNew.svg?style=flat)](https://travis-ci.org/parag-deshpande/RatingsControllerNew)
[![Version](https://img.shields.io/cocoapods/v/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)
[![License](https://img.shields.io/cocoapods/l/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)
[![Platform](https://img.shields.io/cocoapods/p/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RatingsControllerNew is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RatingsControllerNew"
```

##Usage : 
PDRatingsController is singleton class allows user to rate app after user uses app n number of times as specified.
Steps -
1. import PDRatingsView
2. Use following method where you want to initiate rating/review process.
-- [[PDRatingsView ratings]initilizeWithAppId:@"12345" appName:@"abc" countAppUsed:2];
3. Call on Button tap /action event / where user want to display rate promts
-- [[PDRatingsView ratings] checkCountForAppUsedAndDisplayAlertOn:self];'


## Author

parag-deshpande, parag.deshpande@klouddata.com

## License

RatingsControllerNew is available under the MIT license. See the LICENSE file for more info.
