//
//  ViewController.m
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/1.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "SecondController.h"
#import "TransitionsAnimation.h"


@interface SecondController ()<UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton* _push;
    NSMutableArray<UIViewController*> *_childViewControllers;
    UITableView* _tableView;
}
@end

@implementation SecondController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 40;
    _tableView.sectionHeaderHeight = 20;
    [self.view addSubview:_tableView];
    _push = [[UIButton alloc]initWithFrame:CGRectMake(100, 64, 200, 50)];
    [_push addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_push];
    [_push setTitle:@"pop" forState:UIControlStateNormal];
    [_push setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
-(void)push:(UIButton*)btn{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    
}
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return _animation;
//}

@end
