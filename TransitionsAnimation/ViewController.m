//
//  ViewController.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/1.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
#import "TransitionsAnimation.h"
#import "TransitionsAnimationManager.h"

@interface TA : NSObject

@end
@implementation TA
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"INIT TA");
    }
    return self;
}

@end
@interface TB : TA

@end
@implementation TB
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"INIT TB");
    }
    return self;
}

@end
@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    TransitionsAnimationManager* _animation;
    NSMutableArray<UIViewController*> *_childViewControllers;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor redColor];
    self.transitioningDelegate = self;
    self.navigationController.navigationBar.translucent = NO;
    _animation = [[TransitionsAnimationManager alloc]init];

    

   _childViewControllers =  [self _configuredChildViewControllers];

    [_animation startListenGestureFromeController:self toController:_childViewControllers[0] presentModel:gesturePresentTypeModel];
//    for (UIViewController* child in childs) {
//        [self addChildViewController:child];
//    }
//
//    // Do any additional setup after loading the view, typically from a nib.
}
- (NSMutableArray *)_configuredChildViewControllers {
    
    // Set colors, titles and tab bar button icons which are used by the ContainerViewController class for display in its button pane.
    
    NSMutableArray *childViewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    NSArray *configurations = @[
                                @{@"title": @"First", @"color": [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]},
//                                @{@"title": @"Second", @"color": [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1]},
//                                @{@"title": @"Third", @"color": [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1]},
                                ];
    
    for (NSDictionary *configuration in configurations) {
        SecondController *childViewController = [[SecondController alloc] init];
        
        childViewController.title = configuration[@"title"];
        childViewController.view.backgroundColor = configuration[@"color"];
        childViewController.tabBarItem.image = [UIImage imageNamed:configuration[@"title"]];
        childViewController.tabBarItem.selectedImage = [UIImage imageNamed:[configuration[@"title"] stringByAppendingString:@" Selected"]];
//        childViewController.view.userInteractionEnabled = NO;
        [childViewControllers addObject:childViewController];
    }
    return childViewControllers;
}
int indexs = 0;
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UIViewController* controller = _childViewControllers[indexs++ %_childViewControllers.count];
//    [self.navigationController pushViewController:controller animated:YES];
////    [self.view addSubview:controller.view];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return _animation;
//}

@end
