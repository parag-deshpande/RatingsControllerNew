//
//  PDViewController.m
//  RatingsControllerNew
//
//  Created by parag-deshpande on 12/21/2016.
//  Copyright (c) 2016 parag-deshpande. All rights reserved.
//

#import "PDViewController.h"
#import "PDRatingsView.h"


@interface PDViewController ()

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)rateNow:(id)sender {
    
     [[PDRatingsView ratings] checkCountForAppUsedAndDisplayAlertOn:self];
}
@end
