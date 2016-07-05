//
//  PageCoverTransitionsAnimation.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "PageCoverTransitionsAnimation.h"

@implementation PageCoverTransitionsAnimation
-(instancetype)initWithDirection:(PageCoverDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
    }
    return self;
}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
//    switch (_direction) {
//        case pageCoverDirectionToLeft:
//            break;
//        case pageCoverDirectionToRight:
//            break;
//        case pageCoverDirectionToUp:
//            break;
//        case pageCoverDirectionToDown:
//            break;
//            
//        default:
//            break;
//    }
//}
/**
 *  执行push过渡动画
 */
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    //对tempView做动画，避免bug;
//    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = fromVC.view.frame;
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
//    [containerView addSubview:tempView];
//    fromVC.view.hidden = YES;
//    CGPoint point;
//    CAGradientLayer *fromGradient = [CAGradientLayer layer];
//    CAGradientLayer *toGradient = [CAGradientLayer layer];
//    switch (_direction) {
//        case pageCoverDirectionToLeft:
//            break;
//        case pageCoverDirectionToRight:
//            break;
//        case pageCoverDirectionToUp:
//            break;
//        case pageCoverDirectionToDown:
//            break;
//            
//        default:
//            break;
//    }
//
//    point = CGPointMake(0.0,0.5);
//    tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
//    tempView.layer.anchorPoint = point;
//    CATransform3D transfrom3d = CATransform3DIdentity;
//    transfrom3d.m34 = -0.002;
//    containerView.layer.sublayerTransform = transfrom3d;
//    //增加阴影
//    
//    fromGradient.frame = fromVC.view.bounds;
//    fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
//                            (id)[UIColor blackColor].CGColor];
//    fromGradient.startPoint = CGPointMake(0.0, 0.5);
//    fromGradient.endPoint = CGPointMake(0.8, 0.5);
//    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
//    fromShadow.backgroundColor = [UIColor clearColor];
//    [fromShadow.layer insertSublayer:fromGradient atIndex:1];
//    fromShadow.alpha = 0.0;
//    [tempView addSubview:fromShadow];
//
//    toGradient.frame = fromVC.view.bounds;
//    toGradient.colors = @[(id)[UIColor blackColor].CGColor,
//                          (id)[UIColor blackColor].CGColor];
//    toGradient.startPoint = CGPointMake(0.0, 0.5);
//    toGradient.endPoint = CGPointMake(0.8, 0.5);
//    UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
//    toShadow.backgroundColor = [UIColor clearColor];
//    [toShadow.layer insertSublayer:toGradient atIndex:1];
//    toShadow.alpha = 1.0;
//    [toVC.view addSubview:toShadow];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//        fromShadow.alpha = 1.0;
//        toShadow.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        if ([transitionContext transitionWasCancelled]) {
//            [tempView removeFromSuperview];
//            fromVC.view.hidden = NO;
//        }
//    }];
//}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_direction) {
        case pageCoverDirectionToLeft:
            [self doPushAnimation:transitionContext];
            break;
            
        case pageCoverDirectionToRight:
            [self doPopAnimation:transitionContext];
            break;
        default:break;
    }
}

/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
   
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
     CGRect rect = tempView.frame;
    rect.origin.x = -rect.size.width;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = rect;
        tempView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}
/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //拿到push时候的
    UIView *tempView = containerView.subviews.lastObject;
    CGRect rect = tempView.frame;
    rect.origin.x = 0;

//    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.alpha = 1.0;
        tempView.frame = rect;;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
        }
    }];
    
}

@end
