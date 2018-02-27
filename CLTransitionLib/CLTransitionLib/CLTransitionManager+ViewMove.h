//
//  CLTransitionManager+ViewMove.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionManager.h"

@interface CLTransitionManager (ViewMove)

- (void)viewMoveNextWithType:(CLTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)viewMoveBackWithType:(CLTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
