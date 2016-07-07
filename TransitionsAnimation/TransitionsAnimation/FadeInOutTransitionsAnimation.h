//
//  FadeInOutTransitionsAnimation.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/6.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "TransitionsAnimation.h"
typedef enum FadeInOutDirection{
    fadeInOutDirectionToLeft,
    fadeInOutDirectionToRight,
    fadeInOutDirectionToUp,
    fadeInOutDirectionToDown
}FadeInOutDirection;

typedef enum FadeInOutType{
    fadeInOutTypeIn,
    fadeInOutTypeOut
}FadeInOutType;
@interface FadeInOutTransitionsAnimation : TransitionsAnimation
@property(nonatomic,assign)FadeInOutDirection direction;
@property(nonatomic,assign)FadeInOutType fadeInOutType;

-(instancetype)initWithDirection:(FadeInOutDirection)direction type:(FadeInOutType)fadeInOutType;
@end
