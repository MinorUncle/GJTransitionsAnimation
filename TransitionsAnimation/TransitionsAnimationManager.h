//
//  TransitionsAnimationManager.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GestureInteractiveTransition.h"
#import "TransitionsAnimation.h"
#import "GestureInteractive.h"

typedef enum AnimationOperation{
    animationOperationPush,
    animationOperationPop,
    animationOperationPresent,
    animationOperationDissmiss
}AnimationOperation;


//手势触发时窗口弹出类型，默认
typedef enum GesturePresentType{
    gesturePresentTypeNone,//default
    gesturePresentTypeNoModel, //navigation push
    gesturePresentTypeModel//present,dissmiss
}GesturePresentType;


@interface TransitionsAnimationManager : NSObject<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,GestureInteractiveTransitionDelegate>
@property(nonatomic,readonly,assign)GesturePresentType presentType;
@property(nonatomic,readonly,assign)AnimationOperation animationOperation;

@property(nonatomic,weak)UIViewController* presentedC;
@property(nonatomic,weak)UIViewController* presentingC;


//default nil

//default nil ignore gestureInteractiveTransitionType if set;
@property(nonatomic,retain)GestureInteractiveTransition* popGestureInteractiveTransition;
@property(nonatomic,retain)GestureInteractiveTransition* pushGestureInteractiveTransition;

@property(nonatomic,retain)TransitionsAnimation* pushTransitionAnimation;
@property(nonatomic,retain)TransitionsAnimation* popTransitionAnimation;


- (void)startListenGestureFromeController:(UIViewController*)fC toController:(UIViewController *)tC  presentModel:(GesturePresentType)presentTpye;

@end
