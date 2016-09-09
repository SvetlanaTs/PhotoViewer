//
//  PhotoService.h
//  VKPhotoViewer
//
//  Created by Svetlana on 09.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoService : NSObject

+ (void)getPhotoListFromVKRequestWithSuccess:(void (^)(NSArray *photos))success failure:(void(^)(NSError *error))failure;

@end
