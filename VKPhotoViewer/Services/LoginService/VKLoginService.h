//
//  VKLoginService.h
//  VKPhotoViewer
//
//  Created by Svetlana on 08.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VKLoginService : NSObject

@property (nonatomic) UIViewController *viewController;

- (instancetype)initWithAppID:(NSString *)appId scope:(NSArray *)scope;
- (void)authorize:(NSArray *)scope;
+ (void)logout;

@end
