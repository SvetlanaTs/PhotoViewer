//
//  ActionButton.h
//  VKPhotoViewer
//
//  Created by Svetlana on 07.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionButtonDelegate <NSObject>

- (void)performAction:(id)sender;

@end

@interface ActionButton : UIButton

@property (nonatomic, weak) id<ActionButtonDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
