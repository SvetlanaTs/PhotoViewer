//
//  ActionButton.m
//  VKPhotoViewer
//
//  Created by Svetlana on 07.09.16.
//  Copyright © 2016 Svetlana Tsetsorina. All rights reserved.
//

#import "ActionButton.h"

@implementation ActionButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)performAction:(id)sender {
    [self.delegate performAction:sender];
}


@end
