//
//  TransitionsAnimation.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/1.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "TransitionsAnimation.h"

@interface TransitionsAnimation (){
    GestureInteractiveTransition* _interactiveTransition;

}
@property(nonatomic,weak)UIViewController* currentFromeController;
@property(nonatomic,weak)UIViewController* currentToController;
@end
@implementation TransitionsAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
}


@end
