//
//  TransitionsAnimationManager.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GestureTransitionsAnimation.h"
#import "PanGestureInteractive.h"
#import "FadeInOutTransitionsAnimation.h"
@interface GestureTransitionsAnimation()
@property (nonatomic, assign) UINavigationControllerOperation currentOperation;

@end;

@implementation GestureTransitionsAnimation
- (instancetype)initWithToController:(UIViewController*)tC presentModel:(GesturePresentType)presentTpye
{
    self = [super init];
    if (self) {
        _presentType = presentTpye;
        self.presentingC = tC;
    }
    return self;
}

-(void)setPresentedC:(UIViewController *)presentedC{
    if (_presentedC != presentedC) {
        _pushGestureInteractiveTransition = nil;
        _presentedC = presentedC;
        if (_pushGestureInteractiveTransition == nil) {
            _pushGestureInteractiveTransition = [self defaultPushGestureInteractiveTransition];
        }
        if(_presentType == gesturePresentTypeNoModel){
            presentedC.navigationController.delegate = self;
        }
    }
}
-(void)setPresentingC:(UIViewController *)presentingC{
    if (_presentingC != presentingC) {
        _popGestureInteractiveTransition = nil;
        _presentingC = presentingC;

    }
}

-(GestureInteractiveTransition *)popGestureInteractiveTransition{
    if (_popGestureInteractiveTransition == nil) {
        _popGestureInteractiveTransition = [self defaultPopGestureInteractiveTransition];
    }
    return _popGestureInteractiveTransition;
}
-(GestureInteractiveTransition *)pushGestureInteractiveTransition{
    if (_pushGestureInteractiveTransition == nil) {
        _pushGestureInteractiveTransition = [self defaultPushGestureInteractiveTransition];
    }
    return _pushGestureInteractiveTransition;
}
-(GestureInteractiveTransition*)defaultPopGestureInteractiveTransition{
    PanGestureInteractive* gestureDefault = [[PanGestureInteractive alloc]initWithRespondView:_presentingC.view PanGestureDirection:panGestureDirectionDirectionToRight];
    GestureInteractiveTransition* defaultPopTransition = [[GestureInteractiveTransition alloc]initWithGestureInteractive:gestureDefault];
    defaultPopTransition.transitionDelegate = self;
    return defaultPopTransition;
}
-(GestureInteractiveTransition*)defaultPushGestureInteractiveTransition{
    PanGestureInteractive* gestureDefault = [[PanGestureInteractive alloc]initWithRespondView:_presentedC.view PanGestureDirection:panGestureDirectionDirectionToLeft];
    GestureInteractiveTransition* defaultPushTransition = [[GestureInteractiveTransition alloc]initWithGestureInteractive:gestureDefault];
    defaultPushTransition.transitionDelegate = self;
    return defaultPushTransition;
}

-(TransitionsAnimation *)pushTransitionAnimation{
    if (_pushTransitionAnimation == nil) {
        _pushTransitionAnimation = [[FadeInOutTransitionsAnimation alloc]initWithDirection:fadeInOutDirectionToLeft type:fadeInOutTypeIn];
    }
    return _pushTransitionAnimation;
}
-(TransitionsAnimation *)popTransitionAnimation{
    if (_popTransitionAnimation == nil) {
        _popTransitionAnimation = [[FadeInOutTransitionsAnimation alloc]initWithDirection:fadeInOutDirectionToRight type:fadeInOutTypeOut];
    }
    return _popTransitionAnimation;
}


#pragma mark --delegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _currentOperation = UINavigationControllerOperationPush;
    id animation = self.pushTransitionAnimation;
    if (self.pushGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
        animation = nil;
    }
    return animation;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _currentOperation = UINavigationControllerOperationPop;
    id animation = self.popTransitionAnimation;
    if (self.popGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
        animation = nil;
    }
    return animation;
};



- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{

    id transition = self.popGestureInteractiveTransition;
    if (self.popGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
        transition = nil;
    }
    return transition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    id transition = self.pushGestureInteractiveTransition;
    if (self.pushGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
        transition = nil;
    }
    return transition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    id transition;
    if (_currentOperation == UINavigationControllerOperationPop) {
        transition = self.popGestureInteractiveTransition;
        if (self.popGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
            transition = nil;
        }
    }else{
        transition = self.pushGestureInteractiveTransition;
        if (self.pushGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
            transition = nil;
        }
    };
    return transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    _currentOperation = operation;
    id animation;
    if (operation == UINavigationControllerOperationPop) {
        animation = self.popTransitionAnimation;
        if (self.popGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
            animation = nil;
        }
    }else{
        animation = self.pushTransitionAnimation;
        if (self.pushGestureInteractiveTransition.gestureInteractive.gestureRecognizer.state != UIGestureRecognizerStateBegan && !self.transitionWithoutGesture) {
            animation = nil;
        }
    };
    return animation;
}


-(void)gestureInteractiveBeginWithTransition:(GestureInteractiveTransition*)gestureInteractiveTransition{
    if (self.presentType == gesturePresentTypeModel) {
        if (gestureInteractiveTransition == self.popGestureInteractiveTransition){
            [self.presentingC dismissViewControllerAnimated:YES completion:nil];
        }else{
            if (_popGestureInteractiveTransition == nil) {
                _popGestureInteractiveTransition = [self defaultPopGestureInteractiveTransition];
            }
            if (_presentType == gesturePresentTypeModel) {
                self.presentingC.transitioningDelegate = self;
            }
            [self.presentedC presentViewController:self.presentingC animated:YES completion:nil];
        }
    }else if(self.presentType != gesturePresentTypeModel){
        self.presentedC.navigationController.delegate = self;
        if  (gestureInteractiveTransition == self.popGestureInteractiveTransition){
            [self.presentedC.navigationController popViewControllerAnimated:YES];
        }else{
            if (_popGestureInteractiveTransition == nil) {
                _popGestureInteractiveTransition = [self defaultPopGestureInteractiveTransition];
            }
            [self.presentedC.navigationController pushViewController:self.presentingC animated:YES];
        }
    }
}
@end
