//
//  AppDelegate.m
//  VKPhotoViewer
//
//  Created by Svetlana on 05.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <VK-ios-sdk/VKSdk.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [LoginViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return YES;
}

@end
