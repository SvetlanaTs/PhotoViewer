//
//  LoginService.h
//  VKPhotoViewer
//
//  Created by Svetlana on 08.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKLoginService.h"

@interface LoginService : NSObject

@property (nonatomic) UIViewController *viewController;

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)authorize;
+ (void)logout;

@end
