//
//  SecondController.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/4.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "SecondController.h"
#import "TransitionsAnimation.h"
@interface SecondController()<UIViewControllerTransitioningDelegate>
{
    TransitionsAnimation* _animation;
    
}
@end
@implementation SecondController
-(void)viewDidLoad{
    [super viewDidLoad];
//    _animation = [[TransitionsAnimation alloc]initWithAnimationType:transitionsAnimationTypePageCover];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
