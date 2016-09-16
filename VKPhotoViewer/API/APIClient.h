//
//  APIClient.h
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIClient : NSObject

+ (APIClient *)sharedInstance;
- (void)authorize;
- (void)logout;
- (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion;

@end
