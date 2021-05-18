//
//  ConsentViewController.m
//  IronSourceDemoApp
//
//  Created by hadia.andar on 5/10/21.
//  Copyright © 2021 supersonic. All rights reserved.
//

#import "ConsentViewController.h"
#import <IronSource/IronSource.h>

#define USERID @"demoapp"
#define APPKEY @"8545d445"

@interface ConsentViewController ()

//Define button properties
@property (weak, nonatomic) IBOutlet UIButton *loadConsentViewButton;
@property (weak, nonatomic) IBOutlet UIButton *showConsentViewButton;
@property (weak, nonatomic) IBOutlet UIButton *segueToMainScreen;

@end

@implementation ConsentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segueToMainScreen setEnabled:NO];
    [ISIntegrationHelper validateIntegration];
    [ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = @(YES);
    
    //[IronSource setRewardedVideoDelegate:self];
    //[IronSource setOfferwallDelegate:self];
    //[IronSource setInterstitialDelegate:self];
    //[IronSource setBannerDelegate:self];
    //[IronSource addImpressionDataDelegate:self];
    [IronSource setConsentViewWithDelegate:self];
    
    NSString *userId = [IronSource advertiserId];
    
    if([userId length] == 0){
        //If we couldn't get the advertiser id, we will use a default one.
        userId = USERID;
    }
    
    [IronSource setUserId:userId];
    
    [IronSource initWithAppKey:APPKEY adUnits:@[IS_INTERSTITIAL, IS_BANNER]];
    
    //[self performSelector:@selector(loadConsentView) withObject:nil afterDelay:0.5];
    
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loadConsentViewTapped:(id)sender {
    [IronSource loadConsentViewWithType:@"pre"];
    [self.loadConsentViewButton setEnabled:NO];
}

- (IBAction)showConsentViewTapped:(id)sender {
    [IronSource showConsentViewWithViewController:self andType:@"pre"];
    [self.showConsentViewButton setEnabled:NO];
}

/*- (void)loadConsentView{
    //[IronSource loadConsentViewWithType:@"pre"];
}*/


#pragma mark - ConsentView Functions
// Consent View was loaded successfully
- (void)consentViewDidLoadSuccess:(NSString *)consentViewType{
    NSLog(@"CONSENT VIEW LOADED SUCCESSFULLY");
    //[IronSource showConsentViewWithViewController:self andType:@"pre"];
};

// Consent view was failed to load
- (void)consentViewDidFailToLoadWithError:(NSError *)error consentViewType:(NSString *)consentViewType{
    
};

// Consent view was displayed successfully
- (void)consentViewDidShowSuccess:(NSString *)consentViewType{
    
};

// Consent view was not displayed, due to error
- (void)consentViewDidFailToShowWithError:(NSError *)error consentViewType:(NSString *)consentViewType{
    
};

// The user pressed the Next buttons
- (void)consentViewDidAccept:(NSString *)consentViewType{
    NSLog(@"SHOW ATT POPUP");
    
    //Go to next screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    
    [self presentViewController: mainVC animated: YES completion: nil];
    
    
    
    
    //[self.segueToMainScreen setEnabled:YES];
    //as of right now, segue to next screen
    
};


@end
