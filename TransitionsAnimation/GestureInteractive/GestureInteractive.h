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
@property(nonatomic,weak)UIView* gestureView;

@property(nonatomic,assign)GestureInteractiveType gestureType;
//当前手势进度
@property(nonatomic,assign)float gesturePercent;
//是否成功，下次开始时初始化为flase，用于执行不到%100时自动完成
@property(nonatomic,assign)BOOL gestureSuccess;
@property(nonatomic,retain)UIGestureRecognizer* gestureRecognizer;
@property(nonatomic,weak)id<GestureInteractiveDelegate> gestureDelegate;

- (instancetype)initWithGestureType:(GestureInteractiveType)type;
@end
