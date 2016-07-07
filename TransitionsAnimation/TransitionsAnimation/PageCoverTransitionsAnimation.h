//
//  PageCoverTransitionsAnimation.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "TransitionsAnimation.h"
typedef enum PageCoverDirection{
    pageCoverDirectionToLeft,
    pageCoverDirectionToRight,
    pageCoverDirectionToUp,
    pageCoverDirectionToDown
}PageCoverDirection;

typedef enum PageCoverInOutType{
    pageCoverInOutTypeIn,
    pageCoverInOutTypeOut
}PageCoverInOutType;
@interface PageCoverTransitionsAnimation : TransitionsAnimation

@property(nonatomic,assign)PageCoverDirection direction;
@property(nonatomic,assign)PageCoverInOutType coverType;

-(instancetype)initWithDirection:(PageCoverDirection)direction coverType:(PageCoverInOutType)coverType;
@end
