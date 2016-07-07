//
//  FadeInOutTransitionsAnimation.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/6.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "FadeInOutTransitionsAnimation.h"
@interface FadeInOutTransitionsAnimation()
{
    CGPoint _currentOrgin;
}
@end

@implementation FadeInOutTransitionsAnimation


-(instancetype)initWithDirection:(FadeInOutDirection)direction type:(FadeInOutType)fadeInOutType{
    self = [super init];
    if (self) {
        _direction = direction;
        _fadeInOutType = fadeInOutType;
    }
    return self;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];

    UIView* frameAnimationView;
    UIView* alphaAnimationView;

    switch (_fadeInOutType) {
        case fadeInOutTypeIn:
            alphaAnimationView = fromVC.view;
            frameAnimationView = toVC.view;
            [containerView addSubview:toVC.view];
            break;
        case fadeInOutTypeOut:
            alphaAnimationView = toVC.view;
            frameAnimationView = fromVC.view;
            alphaAnimationView.alpha = 0.0;
            [containerView insertSubview:toVC.view atIndex:0];
            break;
        default:
            break;
    }

    
    _currentOrgin = frameAnimationView.frame.origin;
    CGRect rect = frameAnimationView.frame;
    switch (_direction) {
        case fadeInOutDirectionToLeft:
        {
            if(_fadeInOutType ==fadeInOutTypeIn){
                rect.origin.x = rect.size.width;
                frameAnimationView.frame = rect;
                rect.origin.x = 0;
            }else{
                rect.origin.x = - rect.size.width;
            }
        }
            break;
        case fadeInOutDirectionToRight:
            if(_fadeInOutType ==fadeInOutTypeIn){
                rect.origin.x = -rect.size.width;
                frameAnimationView.frame = rect;
                rect.origin.x = 0;
            }else{
                rect.origin.x = rect.size.width;
            }
            break;
        case fadeInOutDirectionToUp:
            if(_fadeInOutType ==fadeInOutTypeIn){
                rect.origin.y = rect.size.height;
                frameAnimationView.frame = rect;
                rect.origin.x = 0;
            }else{
                rect.origin.y = -rect.size.height;
            }
            break;
        case fadeInOutDirectionToDown:
            if(_fadeInOutType ==fadeInOutTypeIn){
                rect.origin.y = -rect.size.height;
                frameAnimationView.frame = rect;
                rect.origin.x = 0;
            }else{
                rect.origin.y = rect.size.height;
            }
            break;
        default:break;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        frameAnimationView.frame = rect;
        if(_fadeInOutType ==fadeInOutTypeIn){
            alphaAnimationView.alpha = 0.0;
        }else{
            alphaAnimationView.alpha = 1.0;
        }
    } completion:^(BOOL finished) {
        alphaAnimationView.alpha = 1.0;
        CGRect tRect = rect;
        tRect.origin = _currentOrgin;
        frameAnimationView.frame = tRect;
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        //        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
