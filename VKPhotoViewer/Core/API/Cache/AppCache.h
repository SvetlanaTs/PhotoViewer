//
//  AppCache.h
//  VKPhotoViewer
//
//  Created by Svetlana on 10.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCache : NSObject

+ (AppCache *)sharedInstance;
- (void)saveObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
