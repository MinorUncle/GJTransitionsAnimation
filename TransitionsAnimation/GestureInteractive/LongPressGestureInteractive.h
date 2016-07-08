//
//  LongPressGestureInteractive.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GestureInteractive.h"

@interface LongPressGestureInteractive : GestureInteractive
//total timer
@property(nonatomic,assign)NSTimeInterval totalLenth;
-(instancetype)initWithRespondView:(UIView *)respondView ;
@end
