//
//  CLTransitionManager+SystemAnimation.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionManager.h"

@interface CLTransitionManager (SystemAnimation)<CAAnimationDelegate>

-(void)sysTransitionNextAnimationWithTransition:(CATransition *)transition context:(id<UIViewControllerContextTransitioning>)transitionContext;

-(void)sysTransitionBackAnimationWithTransition:(CATransition *)transition context:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
