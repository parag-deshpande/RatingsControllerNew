//
//  PDRatingsView.m
//  RatingsSample
//
//  Created by Parag on 12/15/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import "PDRatingsView.h"

#define kAppUsedCount @"AppUsedCount"
#define kRemindMeLater @"RemindMeLater"


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
        [preferences setBool:YES forKey:kRemindMeLater];
        [preferences synchronize];
    }
    return self;
}

-(void)dealloc
{
    
}




#pragma mark - method to initialize with required values

-(void)initilizeWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count
{
    ratings->appID = appId;
    ratings->countAppUsed = count;
    
    
    if(appName && appName.length > 0)
    {
        ratings->strAppName = appName;
        ratings->strAppName = [ratings->strAppName stringByAppendingString:@"App"];
    }
    else
    {
        ratings->strAppName = @"App";
    }
    
    NSInteger appUsedCount = [ratings->preferences integerForKey:kAppUsedCount];
    if(appUsedCount >= 0 && appUsedCount < ratings->countAppUsed)
    {
        appUsedCount ++;
        [ratings->preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [ratings->preferences synchronize];
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
        
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
        {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if(success)
            {
            [preferences setBool:YES forKey:kRemindMeLater];
            [preferences synchronize];
            }
        }];
        }
        else
        {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            if(success)
            {
            [preferences setBool:YES forKey:kRemindMeLater];
            [preferences synchronize];
            }
        }
        
    }];
    [alertController addAction:rateSpintally];
    
    UIAlertAction* remindLater = [UIAlertAction actionWithTitle:@"Remind me Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [preferences setBool:YES forKey:kRemindMeLater];
        [preferences synchronize];
        
        if([delegate respondsToSelector:@selector(ratingsSelectedFor:)])
        {
            [delegate ratingsSelectedFor:PDRatingsSelectedToRemindLater];
        }
    }];
    [alertController addAction:remindLater];
    
    
    UIAlertAction* noThanks = [UIAlertAction actionWithTitle:@"No Thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [preferences setBool:NO forKey:kRemindMeLater];
        [preferences synchronize];
        
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
    if(!appID || !viewController)
    {
        NSLog(@"please set appID and viewcontroller to display alert");
            return;
    }
    

    viewController = _viewController;
    assert(countAppUsed);
    
    if(!alertTitle1 || !alertTitle2 || !alertMessage1 || !alertMessage2)
        [self userDefaultAlertMessages];
    
    NSInteger appUsedCount = [preferences integerForKey:kAppUsedCount];
    if(appUsedCount == countAppUsed && [preferences boolForKey:kRemindMeLater])
    {
        
        // show first alert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ %@",alertTitle1,strAppName] message:alertMessage1 preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addAlert2ForSelectingRatingOrRemind];
            });
            
            
        }];
        [alertController addAction:yes];
        
        UIAlertAction* no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            
        }];
        [alertController addAction:no];
        
        if(viewController)
            [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if(appUsedCount < appUsedCount)
        {
            // show first alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"To Rate/Review please use %@ App at least %ld times",strAppName,appUsedCount] message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                
            }];
            [alertController addAction:cancel];
        }
    }
}




@end
