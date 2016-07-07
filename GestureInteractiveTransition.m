//
//  GestureInteractiveTransition.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/4.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GestureInteractiveTransition.h"
#define SUCCESS_PERCENT 0.4
@interface GestureInteractiveTransition()<GestureInteractiveDelegate>
{
//    NSMutableArray<UIGestureRecognizer*>* _gestureRecognizer;
}

@end
@implementation GestureInteractiveTransition

-(instancetype)initWithGestureInteractive:(GestureInteractive*)gestureInteractive{
    self = [super init];
    if (self) {
        self.gestureInteractive = gestureInteractive;
        _successPercent = SUCCESS_PERCENT;
    }
    return self;
}
-(void)setGestureInteractive:(GestureInteractive *)gestureInteractive{
    _gestureInteractive = gestureInteractive;
    _gestureInteractive.gestureDelegate = self;
}
#pragma mark --
-(void)gestureBeginWithInteractive:(GestureInteractive *)gestureInteractive{
    if ([self.transitionDelegate respondsToSelector:@selector(gestureInteractiveBeginWithTransition:)]) {
        [self.transitionDelegate gestureInteractiveBeginWithTransition:self];
    }
}
-(void)gestureEndWithInteractive:(GestureInteractive *)gestureInteractive{
 //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
    if (gestureInteractive.gesturePercent > self.successPercent) {
        [self finishInteractiveTransition];
    }else{
        [self cancelInteractiveTransition];
    }
}
-(void)gestureInteractive:(GestureInteractive*)gestureInteractive updateWithPercent:(float)percent{
    //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
    [self updateInteractiveTransition:percent];
}

@end
