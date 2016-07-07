//
//  TransitionsAnimation.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/1.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "TransitionsAnimation.h"
#define DEFAULT_DURATION 0.5

@interface TransitionsAnimation (){
    GestureInteractiveTransition* _interactiveTransition;

}
@property(nonatomic,weak)UIViewController* currentFromeController;
@property(nonatomic,weak)UIViewController* currentToController;
@end
@implementation TransitionsAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _transitionDuration <= 0 ? DEFAULT_DURATION:_transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
}


@end
