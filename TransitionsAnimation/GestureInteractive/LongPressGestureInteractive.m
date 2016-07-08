//
//  LongPressGestureInteractive.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "LongPressGestureInteractive.h"
#define TOTAL_TIME 2.0
#define SUCCESS_PERCENT 0.4

@implementation LongPressGestureInteractive
{
    NSDate* _startDate;
}
-(instancetype)initWithRespondView:(UIView *)respondView{
    self = [super initWithGestureType:gestureInteractiveTypePan];
    if (self) {
        _totalLenth = TOTAL_TIME;
        UILongPressGestureRecognizer* recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureResponse:)];
        recognizer.minimumPressDuration = 0.0;
        self.gestureRecognizer = recognizer;
        [respondView addGestureRecognizer:self.gestureRecognizer];
        [super setGestureView:respondView];
    }
    return self;
}
-(void)setGestureView:(UIView *)gestureView{
    [super setGestureView:gestureView];
    [self.gestureRecognizer removeTarget:nil action:nil];
    [gestureView addGestureRecognizer:self.gestureRecognizer];
}
-(void)gestureResponse:(UILongPressGestureRecognizer*)panGesture{
    //手势百分比
    NSLog(@"statusL:%ld",(long)panGesture.state);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _startDate = [NSDate date];
            //手势开始的时候标记手势状态，并开始相应的事件
            self.gestureSuccess = NO;
            if ([self.gestureDelegate respondsToSelector:@selector(gestureBeginWithInteractive:)]) {
                [self.gestureDelegate gestureBeginWithInteractive:self];
            }
            break;
        case UIGestureRecognizerStateChanged:{
            NSTimeInterval d = [[NSDate date]timeIntervalSinceDate:_startDate];
            self.gesturePercent = d/self.totalLenth;
            NSLog(@"percent:%f",self.gesturePercent);

            self.gestureSuccess = self.gesturePercent >= SUCCESS_PERCENT;
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            if ([self.gestureDelegate respondsToSelector:@selector(gestureInteractive:updateWithPercent:)]) {
                [self.gestureDelegate gestureInteractive:self updateWithPercent:self.gesturePercent];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            if ([self.gestureDelegate respondsToSelector:@selector(gestureEndWithInteractive:)])
            {
                [self.gestureDelegate gestureEndWithInteractive:self];
            }
            break;
        }
        default:
            break;
    }
}
-(void)updateTime:(NSTimer*)timer{

}

@end
