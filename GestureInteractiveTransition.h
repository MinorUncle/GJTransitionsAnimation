//
//  GestureInteractiveTransition.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/4.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureInteractive.h"

@class GestureInteractiveTransition;
@protocol GestureInteractiveTransitionDelegate <NSObject>
-(void)gestureInteractiveBeginWithTransition:(GestureInteractiveTransition*)gestureInteractiveTransition;
@end

@interface GestureInteractiveTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic,weak)id<GestureInteractiveTransitionDelegate> transitionDelegate;
@property(nonatomic,assign)float successPercent;

@property(nonatomic,retain)GestureInteractive* gestureInteractive;
-(instancetype)initWithGestureInteractive:(GestureInteractive*)gestureInteractive;
@end
