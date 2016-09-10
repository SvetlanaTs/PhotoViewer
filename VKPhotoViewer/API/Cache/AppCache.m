//
//  AppCache.m
//  VKPhotoViewer
//
//  Created by Svetlana on 10.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "AppCache.h"

@implementation AppCache {
    NSCache *cache;
}

+ (AppCache *)sharedInstance {
    static AppCache *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AppCache new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        cache = [NSCache new];
    }
    return self;
}

- (void)saveObject:(id)object forKey:(NSString *)key {
    [cache setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key {
    return [cache objectForKey:key];
}

@end
