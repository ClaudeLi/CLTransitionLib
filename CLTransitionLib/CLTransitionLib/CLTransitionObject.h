//
//  CLTransitionObject.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CLTransitionConfig.h"

@interface CLTransitionObject : NSObject

/**
 *  转场动画时间
 *
 *  transitiion animation time
 */
@property (nonatomic, assign) NSTimeInterval animationTime;

/**
 *  转场方式 ：push,pop,present,dismiss
 *
 *  transitiion type ：push,pop,present,dismiss
 */
@property (nonatomic, assign) CLTransitionType transitionType;

/**
 *  转场动画类型
 *
 *  transitiion animation type
 */
@property (nonatomic, assign) CLTransitionAnimationType animationType;

/**
 *  系统专场动画
 *
 *  transitiion animation type
 */
@property (nonatomic, strong) CATransition *systemTransition;

/**
 *  是否采用系统原生返回方式
 *  set YES to make back action of systerm
 */
@property (nonatomic, assign) BOOL isSysBackAnimation;

/**
 *  是否通过手势返回
 *  set YES to enable gesture for back
 */
@property (nonatomic, assign) BOOL enableBackGesture;

/**
 *  在动画之前隐藏NavigationBar,动画结束后显示,默认为YES
 *  hide NavigationBar befroe animation , then show NavigationBar after animation
 */
@property (nonatomic, assign) BOOL autoHideNavigationBar;

/**
 *  在动画之前隐藏TabBar,动画结束后显示,默认为YES
 *  hide TabBar befroe animation , then show TabBar after animation
 */
@property (nonatomic, assign) BOOL autoHideTabBar;

/**
 *  返回上个界面的手势 默认：右滑 ：CLGestureTypePanRight
 *  choose type of gesture for back , default : CLGestureTypePanRight
 */
@property (nonatomic,assign) CLGestureType gestureType;

/**
 *  View move 等动画中指定的起始视图
 *
 */
@property (nonatomic, strong) UIView     *startView;
/**
 *  View move 等动画中指定的结束视图
 *
 */
@property (nonatomic, strong) UIView     *targetView;


@end
