//
//  PDRatingsView.m
//  RatingsSample
//
//  Created by Parag on 12/15/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import "PDRatingsView.h"

#define kAppUsedCount                   @"AppUsedCount"
#define kUseRatingsFeatureCaption       @"CaptionRatingsFeature"

#define RemindMeLater                   @"Remind me later"
#define NoThanks                        @"No Thanks"
#define FirstTime                       @"First Time"
#define RemindMeOccured                 @"Remind Me Occured"
#define RatingPerformed                 @"Rating Performed"

#define kUserDateRemindMeLater          @"RemindLaterDate"
#define MAX_REMIND_ME_LATER_DIFF        60*60




@interface PDRatingsView()
{
    UIViewController *viewController;
    UIAlertController *alertController1;
    UIAlertController *alertController2;
    NSUserDefaults *preferences;
    NSString *strAppName;
    NSString *appID;
    NSInteger countAppUsed;
    NSString *alertTitle1;
    NSString *alertTitle2;
    NSString *alertMessage1;
    NSString *alertMessage2;
    CGFloat   remindAfterDays;
}

@end

@implementation PDRatingsView
static PDRatingsView *ratings;

@synthesize delegate;



#pragma mark For Creating Synchronized Singleton Class

+(PDRatingsView *) ratings
{
    @synchronized(self)
    {
        if(!ratings)
            ratings = [[PDRatingsView alloc] init];
        
        
        return ratings;
    }
    return nil;
}

-(id)init
{
    if(self = [super init])
    {
        preferences = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)dealloc
{
    
}




#pragma mark - method to initialize with required values

-(void)initialiseWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count remindAfterDays:(CGFloat)remindAfter
{
      appID = appId;
    
    if(count < 2)
        count = 2;
    
      countAppUsed = count + 1;
    
    if(remindAfter <= 0.0)
        remindAfter = 1; //default after 24 hours
    
    remindAfterDays = remindAfter;
    
    
    if(appName && appName.length > 0)
    {
          strAppName = appName;
          strAppName = [  strAppName stringByAppendingString:@" App"];
    }
    else
    {
          strAppName = @"App";
    }
    
    NSInteger appUsedCount = [  preferences integerForKey:kAppUsedCount];
    if(appUsedCount >= 0 && appUsedCount <   countAppUsed)
    {
        appUsedCount ++;
        [  preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [  preferences synchronize];
    }
}

#pragma mark - methods to set alert title and messages

-(void)setAlertTitle1:(NSString *)alertTitle
{
    alertTitle1 = nil;
    alertTitle1 = alertTitle;
}

-(void)setAlertTitle2:(NSString *)alertTitle
{
    alertTitle2 = nil;
    alertTitle2 = alertTitle;
}

-(void)setAlertMessage1:(NSString *)alertMessage
{
    alertMessage1 = nil;
    alertMessage1 = alertMessage;
}

-(void)setAlertMessage2:(NSString *)alertMessage
{
    alertMessage2 = nil;
    alertMessage2 = alertMessage;
}

#pragma mark - set default alert title and messages if not set

-(void)userDefaultAlertMessages
{
    if(!alertTitle1)
    alertTitle1 = @"Do you love the";
    
    if(!alertMessage1)
    alertMessage1 = @" ";
    
    if(!alertTitle2)
    alertTitle2 = @"Thank you";
    
    
    if(!alertMessage2)
    alertMessage2 = @"We are thrilled to hear you are fan of the app. If you have a second, please rate it";
}


#pragma mark - method to add 2nd promt / dialog

-(void)addAlert2ForSelectingRatingOrRemind
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle2 message:alertMessage2 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* rateSpintally = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Rate %@",strAppName] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    

        NSURL *url =  [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/%@%ld",([[UIDevice currentDevice].systemVersion floatValue] <= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, (long)appID.integerValue]];
        
        
        NSInteger appUsedCount = 0;
        [ preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [ preferences setObject:RatingPerformed forKey:kUseRatingsFeatureCaption];
        [ preferences synchronize];
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
        {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
                
            
        }];
            
        }
        else
        {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            
        }
        
    }];
    [alertController addAction:rateSpintally];
    
    UIAlertAction* remindLater = [UIAlertAction actionWithTitle:@"Remind me Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [ preferences setObject:RemindMeLater forKey:kUseRatingsFeatureCaption];
        [ preferences setObject:[NSDate date] forKey:kUserDateRemindMeLater];
        
        [ preferences synchronize];
        
        if([delegate respondsToSelector:@selector(ratingsSelectedFor:)])
        {
            [delegate ratingsSelectedFor:PDRatingsSelectedToRemindLater];
        }
    }];
    [alertController addAction:remindLater];
    
    
    UIAlertAction* noThanks = [UIAlertAction actionWithTitle:@"No Thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSInteger appUsedCount = 0;
        [  preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [ preferences setObject:NoThanks forKey:kUseRatingsFeatureCaption];
        [ preferences synchronize];
        
        if([delegate respondsToSelector:@selector(ratingsSelectedFor:)])
        {
            [delegate ratingsSelectedFor:PDRatingsSelectedNoThanks];
        }
        
    }];
    [alertController addAction:noThanks];
    
    if(viewController)
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - method to check count and display alert on viewcontroller

-(void)checkCountForAppUsedAndDisplayAlertOn:(UIViewController*)_viewController
{
    viewController = _viewController;
    if(!appID || !viewController)
    {
        NSLog(@"please set appID and viewcontroller to display alert");
            return;
    }
    
    assert(countAppUsed);
    
    if(!alertTitle1 || !alertTitle2 || !alertMessage1 || !alertMessage2)
        [self userDefaultAlertMessages];
    
    NSInteger appUsedCount = [ preferences integerForKey:kAppUsedCount];
    NSString *useRatingsFeature = [preferences objectForKey:kUseRatingsFeatureCaption];
    if(!useRatingsFeature)// this means first time
        useRatingsFeature = FirstTime;
    NSDate *dateUserSetRemindMeLater = [preferences objectForKey:kUserDateRemindMeLater];
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeDiff = [currentDate timeIntervalSinceDate:dateUserSetRemindMeLater];
    
    if((appUsedCount  ==  countAppUsed  && ![useRatingsFeature isEqualToString:RemindMeLater]) || ([useRatingsFeature isEqualToString:RemindMeLater] && timeDiff > MAX_REMIND_ME_LATER_DIFF*remindAfterDays*24))
    {
        // show first alert
        [self displayPromts];
        if(timeDiff > MAX_REMIND_ME_LATER_DIFF*remindAfterDays*24) // remind me occured
        {
            //change value for key "kUseRatingsFeatureCaption" to "RemindMeOccured"
            [preferences setObject:RemindMeOccured forKey:kUseRatingsFeatureCaption];
            [preferences synchronize];
        }
    }
    else
    {
        if(appUsedCount < countAppUsed)
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                // show first alert
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"To Rate/Review please use %@ at least %ld times",strAppName,countAppUsed-1] message:@"" preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }];
                [alertController addAction:cancel];
               // if(viewController)
                  //  [viewController presentViewController:alertController animated:YES completion:nil];
            });
        }
        else
        {
           
        }
    }
}


-(void)displayPromts
{
    // show first alert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ %@", alertTitle1, strAppName] message: alertMessage1 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addAlert2ForSelectingRatingOrRemind];
        });
        
        
    }];
    [alertController addAction:yes];
    
    UIAlertAction* no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSInteger appUsedCount = 0;
        [  preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [  preferences synchronize];
    }];
    [alertController addAction:no];
    
    if( viewController)
        [ viewController presentViewController:alertController animated:YES completion:nil];
}


- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}


-(void)resetSessionCountToOriginal
{
    NSInteger appUsedCount = 0;
    [ preferences setInteger:appUsedCount forKey:kAppUsedCount];
    [ preferences setObject:NoThanks forKey:kUseRatingsFeatureCaption];
    [ preferences synchronize];
}



@end
