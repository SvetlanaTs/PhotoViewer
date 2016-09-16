//
//  PhotoServicing.h
//  VKPhotoViewer
//
//  Created by Svetlana on 13.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#ifndef PhotoServicing_h
#define PhotoServicing_h

#endif /* PhotoServicing_h */

@protocol PhotoServicing <NSObject>

- (void)getPhotoListWithCompletion:(void (^)(NSArray *photos))completion;

@end