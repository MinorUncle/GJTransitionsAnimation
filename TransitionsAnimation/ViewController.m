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
#import "GestureTransitionsAnimation.h"
#import "PageCoverTransitionsAnimation.h"
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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton* _push;
    GestureTransitionsAnimation* _animation;
    NSMutableArray<UIViewController*> *_childViewControllers;
    UITableView* _tableView;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一";
//    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 40;
    _tableView.sectionHeaderHeight = 20;
    [self.view addSubview:_tableView];
    _push = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    [_push setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_push addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [_push setTitle:@"push" forState:UIControlStateNormal];

    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;

    
    _childViewControllers =  [self _configuredChildViewControllers];


    self.view.backgroundColor = [UIColor redColor];
//    self.navigationController.navigationBar.translucent = NO;
    _animation = [[GestureTransitionsAnimation alloc]initWithToController:_childViewControllers[0] presentModel:gesturePresentTypeModel];
    _animation.popTransitionAnimation = [[PageCoverTransitionsAnimation alloc]initWithDirection:pageCoverDirectionToRight coverType:pageCoverInOutTypeOut];
    _animation.pushTransitionAnimation = [[PageCoverTransitionsAnimation alloc]initWithDirection:pageCoverDirectionToLeft coverType:pageCoverInOutTypeIn];
    [self addGestureTransitionsAnimation:_animation];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:_push];
    self.navigationItem.rightBarButtonItem = item;



//
//    // Do any additional setup after loading the view, typically from a nib.
}
-(void)push:(UIButton*)btn{
    
//    [self.navigationController pushViewController:_childViewControllers[0] animated:YES];
    [self presentViewController:_childViewControllers[0] animated:YES completion:nil];
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
        
        [childViewControllers addObject:childViewController];
    }
    return childViewControllers;
}
static int indexs = 0;
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UIViewController* controller = _childViewControllers[indexs++ %_childViewControllers.count];
//    [self.navigationController pushViewController:controller animated:YES];
////    [self.view addSubview:controller.view];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static int i =0;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"cell:%d",i++];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self presentViewController:_childViewControllers[0] animated:YES completion:nil];

}
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return _animation;
//}

@end
