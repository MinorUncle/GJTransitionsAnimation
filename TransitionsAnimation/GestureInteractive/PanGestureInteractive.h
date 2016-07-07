//
//  PanGestureInteractive.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GestureInteractive.h"
typedef enum PanGestureDirection{
    panGestureDirectionDirectionToLeft,
    panGestureDirectionDirectionToRight,
    panGestureDirectionDirectionToUp,
    panGestureDirectionDirectionToDown
}PanGestureDirection;

@interface PanGestureInteractive : GestureInteractive
@property(nonatomic,assign)float totalLenth;
@property(nonatomic,assign)PanGestureDirection direction;

-(instancetype)initWithRespondView:(UIView *)respondView PanGestureDirection:(PanGestureDirection)gestureDirection;
@end
