//
//  TransitionsAnimation.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/1.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h>
#import <UIKit/UIViewControllerTransitionCoordinator.h>
#import <UIKit/UINavigationController.h>
#import "GestureInteractiveTransition.h"
typedef enum _TransitionsAnimationType{
    transitionsAnimationTypePageNone,
    transitionsAnimationTypePageCover,
    transitionsAnimationTypePresentOne,
    transitionsAnimationTypeMagicMove,
    transitionsAnimationTypeCircleSpread
}TransitionsAnimationType;


@interface TransitionsAnimation : NSObject<UIViewControllerAnimatedTransitioning>
//animationType， only assign before push or present
@property(nonatomic,assign)TransitionsAnimationType animationType;

@end
