//
//  AppDelegate.m
//  BasicFramework
//
//  Created by u1city on 2019/10/30.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "AppDelegate.h"
#import "SHMainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor cyanColor];
    [self.window makeKeyAndVisible];
    
    SHMainViewController *mainVC = [[SHMainViewController alloc]init];
    self.window.rootViewController = mainVC;
    
    return YES;
}

@end
