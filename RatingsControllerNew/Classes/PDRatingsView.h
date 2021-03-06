//
//  PDRatingsView.h
//  RatingsSample
//
//  Created by Parag on 12/15/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const iOS7AppStoreURLFormat = @"app/id=";
static NSString *const iOSAppStoreURLFormat = @"WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=";



typedef enum : NSUInteger {
    PDRatingsSelectedToRate,
    PDRatingsSelectedToRemindLater,
    PDRatingsSelectedNoThanks,
} PDRatingsSelected;

@protocol PDRatingsViewDelegate <NSObject>

@required
-(void)ratingsSelectedFor:(PDRatingsSelected)ratingsSelectedFor;
@end

@interface PDRatingsView : UIViewController



@property (nonatomic,weak)                      id<PDRatingsViewDelegate> delegate;





/**
 * class method to initialize
 * @return PDRatingsView returns singleton object after initialising
 */
+(PDRatingsView *) ratings;


/**
 * use it after calling ratings to initialize required values
 * @param appId string - provided by apple as app id with itunnesconnect
 * @param appName string - name of app will  be used to display on Promt messages
 * @param count NSInteger - Max count after which user can rate the app
 * @param remindAfter CGFloat - remind me after n days, to set hours use multiplier 1/24 *(number_of_hours)
 * @return void
 */

-(void)initialiseWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count remindAfterDays:(CGFloat)remindAfter;

/**
 * use this method to check Max limit and display the Promts. Call this method on button tap or where you want user should rate app
 * @param viewController UIViewController where you can display promts
 * @return void
 */
-(void)checkCountForAppUsedAndDisplayAlertOn:(UIViewController*)_viewController;


/**
 * set alert message 1 for first promt like "Do you love the app" with option yes/no
 * @param alertMessage NSString alert message
 * @return void    
 */
-(void)setAlertMessage1:(NSString*)alertMessage;



/**
 * set alert message 2 for second promt like "Are you excited to rate app" with option Rate/Remind Me Later/ No Thanks
 * @param alertMessage NSString alert message
 * @return void    
 */
-(void)setAlertMessage2:(NSString*)alertMessage;



/**
 * set alert title 1 for First promt like "select option"
 * @param alertTitle NSString alert title
 * @return void    
 */
-(void)setAlertTitle1:(NSString*)alertTitle;


/**
 * set alert title 2 for second promt
 * @param alertTitle NSString alert title
 * @return void    
 */
-(void)setAlertTitle2:(NSString*)alertTitle;


/**
 * reset count for app used session
 * @return void
 */
-(void)resetSessionCountToOriginal;

@end
