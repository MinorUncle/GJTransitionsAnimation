//
//  GestureInteractive.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GestureInteractive.h"

@implementation GestureInteractive
- (instancetype)initWithGestureType:(GestureInteractiveType)type{
    self = [super init];
    if (self) {
        _gestureType = type;
    }
    return self;
}
@end
