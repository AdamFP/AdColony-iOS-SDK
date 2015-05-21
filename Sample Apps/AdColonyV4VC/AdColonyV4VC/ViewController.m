//
//  ViewController.m
//  AdColonyV4VC
//
//  Created by John Fernandes-Salling on 8/15/12.
//

#import "ViewController.h"
#import "Constants.h"

#import <AdColony/AdColony.h>


@interface ViewController ()
@property IBOutlet UILabel* currencyLabel;
@property IBOutlet UIActivityIndicatorView* spinner;
@property IBOutlet UIButton* button;
- (void)updateCurrencyBalance;
@end


@implementation ViewController
@synthesize currencyLabel, spinner, button;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateCurrencyBalance];
    [self zoneLoading];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* note) {
                                                           [[NSNotificationCenter defaultCenter] removeObserver:self name:kCurrencyBalanceChange object:nil];
                                                           
                                                           [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneReady object:nil];
                                                           [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneOff object:nil];
                                                           [[NSNotificationCenter defaultCenter] removeObserver:self name:kZoneLoading object:nil];
                                                       }];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kCurrencyBalanceChange object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                                                           [self updateCurrencyBalance];
                                                       }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kZoneReady object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                                                           [spinner stopAnimating];
                                                           [spinner setHidden:YES];
                                                           [button setEnabled:YES];
                                                       }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kZoneOff object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                                                           [spinner stopAnimating];
                                                           [spinner setHidden:YES];
                                                           [button setEnabled:NO];
                                                       }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kZoneLoading object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                                                           [self zoneLoading];
                                                       }];
}

- (void)zoneReady {
    [spinner stopAnimating];
    [spinner setHidden:YES];
    [button setEnabled:YES];
}

- (void)zoneOff {
    [spinner stopAnimating];
    [spinner setHidden:YES];
    [button setEnabled:NO];
}

- (void)zoneLoading {
    [spinner setHidden:NO];
    [spinner startAnimating];
    [button setEnabled:NO];
}

// Get currency balance from persistent storage and display it
- (void)updateCurrencyBalance {
    NSNumber* wrappedBalance = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrencyBalance];
    NSUInteger balance = wrappedBalance && [wrappedBalance isKindOfClass:[NSNumber class]] ? [wrappedBalance unsignedIntValue] : 0;
    [currencyLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)balance]];
}

#pragma mark -
#pragma mark AdColony-specific
- (IBAction)triggerVideo
{
	[AdColony playVideoAdForZone:@"vzf8e4e97704c4445c87504e" withDelegate:nil withV4VCPrePopup:YES andV4VCPostPopup:YES];
}

@end
