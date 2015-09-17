//
//  AppDelegate.m
//  AdColonyBasic
//
//  Created by Owain Moss on 1/13/15.
//  Copyright (c) 2015 AdColony. All rights reserved.
//

#import "AppDelegate.h"

#import <AdColony/AdColony.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Configure AdColony only once, on initial launch
    [AdColony configureWithAppID:@"appbdee68ae27024084bb334a" zoneIDs:@[@"vzf8fb4670a60e4a139d01b5"] delegate:nil logging:YES];
    
    return YES;
}
@end
