//
//  PageCoverTransitionsAnimation.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "PageCoverTransitionsAnimation.h"

@implementation PageCoverTransitionsAnimation

-(instancetype)initWithDirection:(PageCoverDirection)direction coverType:(PageCoverInOutType)coverType{
    self = [super init];
    if (self) {
        _direction = direction;
        _coverType = coverType;
    }
    return self;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    UIView *containerView = [transitionContext containerView];
    UIView *tempView,*fromShadow, *toShadow;
    if (_coverType == pageCoverInOutTypeIn) {
        [containerView addSubview:toVC.view];
        tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        CGPoint point = CGPointMake(0, 0.5);
        tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
        tempView.layer.anchorPoint = point;
        
        CATransform3D transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = -0.002;
        containerView.layer.sublayerTransform = transfrom3d;
        tempView.frame = fromVC.view.frame;
        [containerView addSubview:tempView];
        
        fromShadow = [self createShadowWithView:tempView.bounds];
        fromShadow.alpha = 0.0;
        [tempView addSubview:fromShadow];
        
        toShadow = [self createShadowWithView:toVC.view.bounds];
        toShadow.alpha = 1.0;
        [toVC.view addSubview:toShadow];
    }else{
        tempView = containerView.subviews.lastObject;
        toShadow = [self createShadowWithView:tempView.bounds];
        toShadow.alpha = 1.0;
        [tempView addSubview:toShadow];
        
        fromShadow = [self createShadowWithView:fromVC.view.bounds];
        fromShadow.alpha = 0.0;
        [fromVC.view addSubview:fromShadow];
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromShadow.alpha = 1.0;
        toShadow.alpha = 0.0;
        if (_coverType == pageCoverInOutTypeIn) {
            switch (_direction) {
                case  pageCoverDirectionToLeft:
                    tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
                    break;
                case  pageCoverDirectionToRight:
                    tempView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
                    break;
                case  pageCoverDirectionToUp:
                    tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
                    break;
                case  pageCoverDirectionToDown:
                    tempView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                    break;
                default:
                    break;
            }

        }else{
            tempView.layer.transform = CATransform3DIdentity;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [fromShadow removeFromSuperview];
        [toShadow removeFromSuperview];
        if (_coverType == pageCoverInOutTypeIn) {
            if ([transitionContext transitionWasCancelled]) {
                [tempView removeFromSuperview];
            }
        }else{
            if (![transitionContext transitionWasCancelled]) {
                [tempView removeFromSuperview];
            }
        }
    }];
}
-(UIView*)createShadowWithView:(CGRect)bounds{
    UIView* fromShadow;
    //增加阴影
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
                            (id)[UIColor blackColor].CGColor];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
    fromGradient.endPoint = CGPointMake(0.8, 0.5);
    fromShadow = [[UIView alloc]initWithFrame:bounds];
    fromShadow.backgroundColor = [UIColor clearColor];
    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
    return fromShadow;
}
@end
