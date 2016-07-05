//
//  PanGestureInteractive.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "PanGestureInteractive.h"
@interface PanGestureInteractive()
{

}
@end
@implementation PanGestureInteractive
-(instancetype)initWithRespondView:(UIView *)respondView PanGestureDirection:(PanGestureDirection)gestureDirection
{
    self = [super initWithGestureType:gestureInteractiveTypePan];
    if (self) {
        self.gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureResponse:)];
        [respondView addGestureRecognizer:self.gestureRecognizer];
    }
    return self;
}
-(void)panGestureResponse:(UIPanGestureRecognizer*)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case panGestureDirectionDirectionToLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case panGestureDirectionDirectionToRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case panGestureDirectionDirectionToUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case panGestureDirectionDirectionToDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    self.gesturePercent = persent;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            if ([self.gestureDelegate respondsToSelector:@selector(gestureBeginWithInteractive:)]) {
                [self.gestureDelegate gestureBeginWithInteractive:self];
            }
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            if ([self.gestureDelegate respondsToSelector:@selector(gestureInteractive:updateWithPercent:)]) {
                [self.gestureDelegate gestureInteractive:self updateWithPercent:persent];
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

@end
