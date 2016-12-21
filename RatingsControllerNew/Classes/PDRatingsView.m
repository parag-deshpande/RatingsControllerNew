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
    NSString *strAppName;
}

@end

@implementation PDRatingsView
static PDRatingsView *ratings;

@synthesize alertController1;
@synthesize alertController2;
@synthesize appID;
@synthesize countAppUsed;
@synthesize preferences;
@synthesize delegate;


#pragma mark For Creating Synchronized Singleton Class
+(PDRatingsView *) ratingsWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count onViewController:(UIViewController*)_viewController
{
    @synchronized(self)
    {
        if(!ratings)
        {
            ratings = [[PDRatingsView alloc] init];
            ratings.appID = appId;
            ratings.countAppUsed = count;
            ratings->viewController = _viewController;
            
            if(appName && appName.length > 0)
                ratings->strAppName = appName;
            else
                ratings->strAppName = @"App";
        }
        
        [ratings checkCountForAppUsed];
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

-(void)addAlert2ForSelectingRatingOrRemind
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank you" message:@"We are thrilled to hear you are fan of the app. If you have a second, please rate it" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* rateSpintally = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Rate %@",strAppName] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        if([delegate respondsToSelector:@selector(ratingsSelectedFor:)])
//        {
//            [delegate ratingsSelectedFor:PDRatingsSelectedToRate];
//        }

        NSURL *url =  [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/%@%ld",([[UIDevice currentDevice].systemVersion floatValue] <= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, (long)appID.integerValue]];
        
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
        {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            [preferences setBool:YES forKey:kRemindMeLater];
            [preferences synchronize];
        }];
        }
        else
        {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
            
            [preferences setBool:YES forKey:kRemindMeLater];
            [preferences synchronize];
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

-(void)checkCountForAppUsed
{
    assert(countAppUsed);
    NSInteger appUsedCount = [preferences integerForKey:kAppUsedCount];
    if(appUsedCount >= 0 && appUsedCount < countAppUsed)
    {
        appUsedCount ++;
        [preferences setInteger:appUsedCount forKey:kAppUsedCount];
        [preferences synchronize];
    }
    else
    {
        if(appUsedCount == countAppUsed && [preferences boolForKey:kRemindMeLater])
        {
            
          // show first alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Do you love the %@ App",strAppName] message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            
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
    }

}

-(void)dealloc
{

}




@end
