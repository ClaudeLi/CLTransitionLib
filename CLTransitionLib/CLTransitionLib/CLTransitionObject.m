//
//  CLTransitionObject.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionObject.h"

@implementation CLTransitionObject

-(instancetype)init {
    self = [super init];
    if (self) {
        _animationTime = 0.4;
        self.animationType = CLTransitionAnimationTypeDefault;
        _gestureType = CLGestureTypePanRight;
        _enableBackGesture = YES;
        _autoHideNavigationBar = YES;
        _autoHideTabBar = YES;
    }
    return self;
}

@end
