//
//  CLTransitionConfig.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#ifndef CLTransitionConfig_h
#define CLTransitionConfig_h

typedef NS_ENUM(NSInteger, CLTransitionAnimationType){
    //----------- 自定义 ------------
    CLTransitionAnimationTypeDefault,
    
    CLTransitionAnimationTypeViewMoveElastic,
    CLTransitionAnimationTypeViewMoveNormal,
    
    CLTransitionAnimationTypeInsideThenPush,
};

typedef NS_ENUM(NSInteger, CLTransitionType){
    CLTransitionTypePop,
    CLTransitionTypePush,
    CLTransitionTypePresent,
    CLTransitionTypeDismiss,
};


typedef NS_ENUM(NSInteger, CLGestureType){
    CLGestureTypeNone,
    CLGestureTypePanLeft,
    CLGestureTypePanRight,
    CLGestureTypePanUp,
    CLGestureTypePanDown,
};

#endif /* CLTransitionConfig_h */
