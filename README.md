# RatingsControllerNew

[![CI Status](http://img.shields.io/travis/parag-deshpande/RatingsControllerNew.svg?style=flat)](https://travis-ci.org/parag-deshpande/RatingsControllerNew)
[![Version](https://img.shields.io/cocoapods/v/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)
[![License](https://img.shields.io/cocoapods/l/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)
[![Platform](https://img.shields.io/cocoapods/p/RatingsControllerNew.svg?style=flat)](http://cocoapods.org/pods/RatingsControllerNew)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Introduction
PDRatingsController is used to Rate the App in Appstore. Simple to integrate just add pod in your pod file, install pods and use methods described in usage section.
This has features -
- Custom Alert messages 
    - set promt title's and messages using method
    -(void)setAlertMessage1:(NSString*)alertMessage
    -(void)setAlertMessage2:(NSString*)alertMessage
    -(void)setAlertTitle1:(NSString*)alertTitle
    -(void)setAlertTitle2:(NSString*)alertTitle

- Remind Me Later option is available
    -set days after which user will be promted with App rate/review
    to set hours use mutlipler - 1/24*<number_of_hours>
    to set days set <number_of_days>
   Reminder promts will apear when time set reached and app is lauched 


## Requirements
 available iOS 8.0 and later
## Installation

RatingsControllerNew is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RatingsControllerNew"
```

##Usage 
PDRatingsController is singleton class allows user to rate app after user uses app n number of times as specified. Default is limit is 2 i.e user must use app at least 2 times to rate.
Steps -
1. import PDRatingsView

2. Use following method in AppDelegate's didBecomeActiveMethod  to initiate rating/review process.

-- [[PDRatingsView ratings]initilizeWithAppId:<APP_ID> appName:<APP_NAME> countAppUsed:<COUNT_TO_ALLOW_USER_RATE_APP> remindAfterDays:<NUMBER_OF_DAYS>];

3. Call on Button tap /action event / where user want to display rate promts

-- [[PDRatingsView ratings] checkCountForAppUsedAndDisplayAlertOn:<ViewController_To_Display_Promts>];


## Author

parag-deshpande, parag.deshpande@klouddata.com

## License

RatingsControllerNew is available under the MIT license. See the LICENSE file for more info.
