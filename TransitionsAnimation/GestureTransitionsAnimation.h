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
    gesturePresentTypeNoModel, //navigation push
    gesturePresentTypeModel//present,dissmiss
}GesturePresentType;


@interface GestureTransitionsAnimation : NSObject<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,GestureInteractiveTransitionDelegate>
@property(nonatomic,readonly,assign)GesturePresentType presentType;
@property(nonatomic,readonly,assign)AnimationOperation animationOperation;
@property(nonatomic,weak)UIViewController* presentedC;
@property(nonatomic,weak)UIViewController* presentingC;



//default no
@property(nonatomic,assign)BOOL transitionWithoutGesture;

//default nil ignore gestureInteractiveTransitionType if set;
@property(nonatomic,retain)GestureInteractiveTransition* popGestureInteractiveTransition;
@property(nonatomic,retain)GestureInteractiveTransition* pushGestureInteractiveTransition;

@property(nonatomic,retain)TransitionsAnimation* pushTransitionAnimation;
@property(nonatomic,retain)TransitionsAnimation* popTransitionAnimation;


- (instancetype)initWithToController:(UIViewController*)tC presentModel:(GesturePresentType)presentTpye;
@end

@interface UIViewController (TransitionsAnimation)
-(void)addGestureTransitionsAnimation:(GestureTransitionsAnimation*)gestureAnimation;
@end
@implementation UIViewController(TransitionsAnimation)
-(void)addGestureTransitionsAnimation:(GestureTransitionsAnimation*)gestureAnimation{
    [gestureAnimation setPresentedC:self];
}
@end