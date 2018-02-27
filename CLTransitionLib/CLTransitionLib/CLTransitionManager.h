//
//  CLTransitionManager.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CLTransitionConfig.h"

@interface CLTransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval                    animationTime;
@property (nonatomic, assign) CLTransitionType                  transitionType;
@property (nonatomic, assign) CLTransitionAnimationType         animationType;
@property (nonatomic, assign) CLTransitionAnimationType         backAnimationType;
@property (nonatomic, assign) CLGestureType                     backGestureType;
@property (nonatomic, strong) CATransition                      *systemTransition;

@property (nonatomic, weak) UIView                              *startView;
@property (nonatomic, weak) UIView                              *targetView;

@property (nonatomic, assign) BOOL                              isSysBackAnimation;
@property (nonatomic, assign) BOOL                              enableBackGesture;
@property (nonatomic, assign) BOOL                              autoHideNavigationBar;
@property (nonatomic, assign) BOOL                              autoHideTabBar;


@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);
@property (nonatomic, copy) void(^completionBlock)(void);

+(CLTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet;

- (UIImage *)imageFromView: (UIView *)view atFrame:(CGRect)rect;

@end
