//
//  TransitionsAnimationManager.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "TransitionsAnimationManager.h"
#import "PanGestureInteractive.h"
#import "PageCoverTransitionsAnimation.h"
@interface TransitionsAnimationManager()
@property (nonatomic, assign) UINavigationControllerOperation currentOperation;
@end;

@implementation TransitionsAnimationManager

- (void)startListenGestureFromeController:(UIViewController*)fC toController:(UIViewController *)tC  presentModel:(GesturePresentType)presentTpye{
    _popGestureInteractiveTransition = nil;
    _pushGestureInteractiveTransition = nil;

    _presentType = presentTpye;
    if (presentTpye == gesturePresentTypeModel) {
        tC.transitioningDelegate = self;
    }else if(presentTpye == gesturePresentTypeNoModel){
        fC.navigationController.delegate = self;
    }else{
        if (fC.navigationController != nil) {
            _presentType = gesturePresentTypeNoModel;
            fC.navigationController.delegate = self;
        }else{
            _presentType = gesturePresentTypeModel;
            tC.transitioningDelegate = self;
        }
    }
    _presentedC = fC;
    _presentingC = tC;
    
    if (_pushGestureInteractiveTransition == nil) {
        _pushGestureInteractiveTransition = [self defaultPushGestureInteractiveTransition];
    }
    if (_popGestureInteractiveTransition == nil) {
        _popGestureInteractiveTransition = [self defaultPopGestureInteractiveTransition];
    }
}
-(void)setPresentedC:(UIViewController *)presentedC{
    if (_presentedC != presentedC) {
        _popGestureInteractiveTransition = nil;
        _presentedC = presentedC;
    }
}
-(void)setPresentingC:(UIViewController *)presentingC{
    if (_presentingC != presentingC) {
        _pushGestureInteractiveTransition = nil;
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
        _pushTransitionAnimation = [[PageCoverTransitionsAnimation alloc]initWithDirection:pageCoverDirectionToLeft];
    }
    return _pushTransitionAnimation;
}
-(TransitionsAnimation *)popTransitionAnimation{
    if (_popTransitionAnimation == nil) {
        _popTransitionAnimation = [[PageCoverTransitionsAnimation alloc]initWithDirection:pageCoverDirectionToRight];
    }
    return _popTransitionAnimation;
}
//
//-(id<UIViewControllerAnimatedTransitioning>)presentAnimation{
//    _animationOperation = animationOperationPresent;
//    return self.pushTransitionAnimation;
//}
//-(id<UIViewControllerAnimatedTransitioning>)dissmissAnimation{
//    _animationOperation = animationOperationDissmiss;
//    return self.popTransitionAnimation;
//}
//-(id<UIViewControllerAnimatedTransitioning>)pushAnimation{
//    _animationOperation = animationOperationPush;
//    return self.pushTransitionAnimation;
//}
//-(id<UIViewControllerAnimatedTransitioning>)popAnimation{
//    _animationOperation = animationOperationPop;
//    return self.popTransitionAnimation;
//}



#pragma mark --delegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _currentOperation = UINavigationControllerOperationPush;
    return self.pushTransitionAnimation;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _currentOperation = UINavigationControllerOperationPop;
    return self.popTransitionAnimation;
};



- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{

    return self.popGestureInteractiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return self.pushGestureInteractiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (_currentOperation == UINavigationControllerOperationPop) {
        return self.popGestureInteractiveTransition;
    }else{
        return self.pushGestureInteractiveTransition;
    };
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    _currentOperation = operation;
    if (operation == UINavigationControllerOperationPop) {
        return [self popTransitionAnimation];
    }else{
        return [self pushTransitionAnimation];
    };
}


-(void)gestureInteractiveBeginWithTransition:(GestureInteractiveTransition*)gestureInteractiveTransition{
    if (self.presentType == gesturePresentTypeModel) {
        if (gestureInteractiveTransition == self.popGestureInteractiveTransition){
            [self.presentingC dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.presentedC presentViewController:self.presentingC animated:YES completion:nil];
        }
    }else if(self.presentType != gesturePresentTypeModel){
        if  (gestureInteractiveTransition == self.popGestureInteractiveTransition){
            [self.presentedC.navigationController popViewControllerAnimated:YES];
        }else{
            [self.presentedC.navigationController pushViewController:self.presentingC animated:YES];
        }
    }
}
@end
