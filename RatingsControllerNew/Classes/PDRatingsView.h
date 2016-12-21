//
//  PDRatingsView.h
//  RatingsSample
//
//  Created by Parag on 12/15/16.
//  Copyright © 2016 KloudData. All rights reserved.
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


@property(nonatomic,weak)                       UIAlertController *alertController1;
@property(nonatomic,weak)                       UIAlertController *alertController2;
@property(nonatomic,strong,setter=setAppID:)    NSString *appID;
@property(nonatomic)                            NSInteger countAppUsed;
@property (nonatomic,strong)                    NSUserDefaults *preferences;
@property (nonatomic,weak)                      id<PDRatingsViewDelegate> delegate;


+(PDRatingsView *) ratingsWithAppId:(NSString*)appId appName:(NSString*)appName countAppUsed:(NSInteger)count onViewController:(UIViewController*)_viewController;

@end
