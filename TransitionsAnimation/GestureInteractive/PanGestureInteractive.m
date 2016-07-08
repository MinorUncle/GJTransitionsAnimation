//
//  PanGestureInteractive.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "PanGestureInteractive.h"
#define SUCCESS_PERCENT 0.4
#define DEFALUT_TOTAL_LENTH_PERCENT 0.6
@interface PanGestureInteractive()
{

}
@end
@implementation PanGestureInteractive
-(instancetype)initWithRespondView:(UIView *)respondView PanGestureDirection:(PanGestureDirection)gestureDirection
{
    self = [super initWithGestureType:gestureInteractiveTypePan];
    if (self) {
        _direction = gestureDirection;
        self.gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureResponse:)];
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
-(void)panGestureResponse:(UIPanGestureRecognizer*)panGesture{
    //手势百分比
    CGFloat persent = 0;
    CGPoint point = [panGesture translationInView:panGesture.view];
    switch (_direction) {
        case panGestureDirectionDirectionToLeft:{
            CGFloat transitionX = -point.x;
            persent = transitionX / (_totalLenth <=0 ?panGesture.view.bounds.size.width*DEFALUT_TOTAL_LENTH_PERCENT:_totalLenth);
        }
            break;
        case panGestureDirectionDirectionToRight:{
            CGFloat transitionX = point.x;
            persent = transitionX / (_totalLenth <=0 ?panGesture.view.bounds.size.width*DEFALUT_TOTAL_LENTH_PERCENT:_totalLenth);
        }
            break;
        case panGestureDirectionDirectionToUp:{
            CGFloat transitionY = -point.y;
            persent = transitionY / (_totalLenth <=0 ?panGesture.view.bounds.size.height*DEFALUT_TOTAL_LENTH_PERCENT:_totalLenth);
        }
            break;
        case panGestureDirectionDirectionToDown:{
            CGFloat transitionY = point.y;
            persent = transitionY / (_totalLenth <=0 ?panGesture.view.bounds.size.height*DEFALUT_TOTAL_LENTH_PERCENT:_totalLenth);
        }
            break;
    }
    NSLog(@"poin:%@,%f",[NSValue valueWithCGPoint:point],persent);
    self.gesturePercent = persent;
    if(persent >= SUCCESS_PERCENT){
        self.gestureSuccess = YES;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.gestureSuccess = NO;
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
