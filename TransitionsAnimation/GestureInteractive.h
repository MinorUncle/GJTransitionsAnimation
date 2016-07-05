//
//  GestureInteractive.h
//  TransitionsAnimation
//
//  Created by tongguan on 16/7/5.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum GestureInteractiveType{
    gestureInteractiveTypeNone,
    gestureInteractiveTypePan,
    gestureInteractiveTypeLongPress
}GestureInteractiveType;

@class GestureInteractive;
@protocol GestureInteractiveDelegate <NSObject>
-(void)gestureBeginWithInteractive:(GestureInteractive*)gestureInteractive;
-(void)gestureInteractive:(GestureInteractive*)gestureInteractive updateWithPercent:(float)percent;
-(void)gestureEndWithInteractive:(GestureInteractive*)gestureInteractive;
@end

@interface GestureInteractive : NSObject
@property(nonatomic,assign)GestureInteractiveType gestureType;
@property(nonatomic,assign)float gesturePercent;
@property(nonatomic,retain)UIGestureRecognizer* gestureRecognizer;
@property(nonatomic,weak)id<GestureInteractiveDelegate> gestureDelegate;

- (instancetype)initWithGestureType:(GestureInteractiveType)type;
@end
